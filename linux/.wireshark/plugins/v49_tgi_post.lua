local bit = require("bit")
-- dissects the v49 Protocol (including the TGI specific fields)
-- create a "protocol" for our tree
v49_proto = Proto("v49","Vita49","Vita 49 Protocol")

-- create our fields
frameNum_field = ProtoField.float("FrameNum")

-- add our fields to the protocol
v49_proto.fields = { frameNum_field }

-- then register v49_proto as a postdissector
register_postdissector(v49_proto)

recNum = -1
--insideFFT = false
--prev_FFTEnd_ts = -1
--FFTCnt = 0


local stream_map = {} -- a table per each stream : { req_cnt, resp_cnt, reqs }


-- initialization routine
--localFFTCnt
local insideFFT
local prevFreq
local prev_FFTEnd_ts

function v49_proto.init ()
    stream_map = {}
    insideFFT = false
    FFTCnt = -1
    prevFreq = 0
    prev_FFTEnd_ts = -1
end

function v49_proto.dissector(buffer,pinfo,tree  )
    
    --if pinfo.visited then return end
           
    local log_tree = tree:add(v49_proto,"Log Msgs")
    
    pinfo.cols.protocol = "Vita49"
    local packetnum = pinfo.number
    local ts = pinfo.rel_ts
    local del_ts = pinfo.delta_dis_ts

    local v49_branch = tree:add(v49_proto,buffer(),"Vita 49 Records("..tostring(ts)..", "..tostring(del_ts)..")")

    --fixed_data = v49HeaderBuf:range(4, 4):le_uint()
    --log_tree:add("fixed_data: " .. tostring(fixed_data))
    --frameCnt = bit.rshift(fixed_data, 20)
    --log_tree:add("FrameNum: " .. tostring(frameCnt))
    --frameSize = bit.band(fixed_data, 0xfffff)
    --log_tree:add("frameSize: " .. tostring(frameSize))

    --v49HeaderBuf = buffer(v49Header_offset,v49Header_length)
    --local subtree_payload = v49_branch:add_le(buffer(v49Payload_offset,v49Payload_length), "V49 Payload")
    
    local v49Start = 1448293433  -- '94SV'
    local v49End   = 1447382596  -- '444e4556'  -- 'DNEV'
    --local FFTEnd   = 305419896   -- '34127856'
    local FFTEnd1   = 13330   -- '3412'
    local FFTEnd2   = 30806   -- '7856'
    local wordSize = 4
    local frameDataOffset  = 1 * wordSize
    local packetDataOffset = 2 * wordSize
    local StreamBinOffset  = 3 * wordSize
    local timeOffset       = 4 * wordSize
    local freqOffset       = 5 * wordSize
    local payloadOffset    = 7 * wordSize
    local payloadSize      = 120 * wordSize
    local v49StartCnt = 0
    local v49EndCnt = 0
    local FFTEndCnt = 0
    local streamID = -1
    local delta_ts = 0
    local newFreqCnt = 0
    
    -- fast-forward to first v49 start
    ptr = 0
    --repeat
    --  fixed_data = buffer:range(ptr, 4):le_uint()
    --  ptr = ptr + 1
    --until (fixed_data == v49Start) or (ptr > buffer:len())
    
    new_info = ""
    
    for ptr = 0, (buffer:len()-4) do
         fixed_data = buffer:range(ptr, 4):le_uint()
         if fixed_data == v49Start then
            v49StartCnt = v49StartCnt + 1
            if (ptr + 512) <= buffer:len() then
                v49_buffer = buffer:range(ptr, 512)
            else
                v49_buffer = buffer:range(ptr, buffer:len()-ptr)
            end           
            local v49_rec = v49_branch:add(v49_proto,v49_buffer,"V49 Rec ("..tostring(v49StartCnt)..")")
            if (ptr + frameDataOffset) < buffer:len() then 
                fixed_data = buffer:range((ptr + frameDataOffset), 4):le_uint()
                local frameCnt = bit.rshift(fixed_data, 20)
                local frameSize = bit.band(fixed_data, 0xfffff)
                v49_rec:add(v49_proto,buffer:range((ptr + frameDataOffset), 4),"V49 Frame Count: "..tostring(frameCnt))
            end
            if (ptr + packetDataOffset) < buffer:len() then 
                fixed_data = buffer:range((ptr + packetDataOffset), 4):le_uint()
                local packetCnt =  bit.band(bit.rshift(fixed_data, 16), 0x0F)
                local packetType = bit.rshift(fixed_data, 28)
                v49_rec:add(v49_proto,buffer:range((ptr + packetDataOffset), 4),"Packet Count: "..tostring(packetCnt))
                --v49_rec:add(v49_proto,buffer:range((ptr + packetDataOffset), 4),"Packet Type: "..tostring(packetType))
            end
            if (ptr + StreamBinOffset) < buffer:len() then 
                fixed_data = buffer:range((ptr + StreamBinOffset), 4):le_uint()
                streamID = bit.band(fixed_data, 0xFF)
                local IQG_field = bit.band(bit.rshift(fixed_data, 8), 0x0F)
                local base = 2
                local binSize = base ^ IQG_field
                v49_rec:add(v49_proto,buffer:range((ptr + StreamBinOffset), 4),"Stream ID: "..tostring(streamID))
                --v49_rec:add(v49_proto,buffer:range((ptr + StreamBinOffset), 4),"IQG Field: "..tostring(IQG_field))
                v49_rec:add(v49_proto,buffer:range((ptr + StreamBinOffset), 4),"Bin Size: "..tostring(binSize))
            end
            if (ptr + freqOffset) < buffer:len() then 
                fixed_data = buffer:range((ptr + freqOffset), 4):le_uint()
                local currFreq = fixed_data / 1.0e6
                --new_info = new_info .. currFreq .. ", "
                if currFreq ~= prevFreq then
                    new_info = new_info .. currFreq .. ", "
                    local tmp = FFTCnt
                    tmp = tmp + 1
                    FFTCnt = tmp
                    newFreqCnt = newFreqCnt + 1
                    prevFreq = currFreq
                    delta_ts = ts - prev_FFTEnd_ts
                    prev_FFTEnd_ts = ts                    
                end
                v49_rec:add(v49_proto,buffer:range((ptr + freqOffset), 4),"Freq_MHz: " .. tostring(currFreq))
            end
            if (ptr + payloadOffset) < buffer:len() then
                if (ptr + payloadOffset + payloadSize) <= buffer:len() then
                    v49_payload_buffer = buffer:range((ptr + payloadOffset), payloadSize)
                else
                    v49_payload_buffer = buffer:range((ptr + payloadOffset), buffer:len()-(ptr + payloadOffset))
                end           
                local v49_payload = v49_rec:add(v49_proto,v49_payload_buffer,"V49 Payload ("..tostring(v49_payload_buffer:len()).." bytes)")
                -- handle FFT case (stream 5 or 6)
                if streamID == 5 or streamID == 6 then
                    v49_payload:append_text(" (FFT Data)")
                    local recData = 0
                    local recEnds = 0
                    local BadFFTEndCnt = 0
                    for payload_ptr = 0, (v49_payload_buffer:len()-2), 2 do
                        payload_data = v49_payload_buffer:range(payload_ptr, 2):le_uint()
                        if payload_data == FFTEnd1 then
                            local tmp = v49_payload_buffer:range(payload_ptr+2, 2):le_uint()
                            if tmp == FFTEnd2 then recEnds = recEnds + 1 end
                        else
                            recData = recData + 1
                            if recData == 0 then BadFFTEndCnt = BadFFTEndCnt + 1 end
                        end 
                    end
                    v49_payload:add("Data count: "..tostring(recData))
                    v49_payload:add("FFT End count: "..tostring(recEnds))
                    if BadFFTEndCnt > 0 then
                        v49_payload:add_expert_info(nil, PI_ERROR, "FFT BadFFTEndCnt count: "..tostring(BadFFTEndCnt))
                    end
                end
            end
         end
         --if fixed_data == v49End then
         --   v49EndCnt = v49EndCnt + 1
         --end
         --if fixed_data == FFTEnd then
         --  FFTEndCnt = FFTEndCnt + 1
            --if insideFFT == true then
            --  insideFFT = false
            --  FFTCnt = FFTCnt + 1
            --  if prev_FFTEnd_ts > -1 then
            --      local delta_ts = ts - prev_FFTEnd_ts
            --      log_tree:add("delta_ts: " .. tostring(delta_ts))
            --  end
            --  prev_FFTEnd_ts = ts
            --end
         --end
    end
    
    --v49_branch:add("Num V49Starts: " .. tostring(v49StartCnt))
    --v49_branch:add("Num V49Ends  : " .. tostring(v49StartCnt))
    --v49_branch:add("Num FFTEnds  : " .. tostring(FFTEndCnt))
    --v49_branch:add("insideFFT    : " .. tostring(insideFFT))

    --new_info = "V49Starts: " .. v49StartCnt
    --new_info = new_info .. ", V49Ends: " .. v49StartCnt
    --new_info = new_info .. ", FFTEnds: " .. FFTEndCnt
    --new_info = new_info .. ", insideFFT: " .. tostring(insideFFT)
    new_info = new_info .. newFreqCnt
    new_info = new_info .. ", " .. FFTCnt
    new_info = new_info .. ", " .. delta_ts
    pinfo.cols.info = new_info
    
    
end


