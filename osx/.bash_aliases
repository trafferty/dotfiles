# installed exa (brew install exa), so here is an alias:
alias ls='exa --group-directories-first'
#alias ls="ls -G"
alias lsa="ls -alhF"
alias ls1="ls -1"

# add some aliases for exe:
alias lst='exa -T'
alias lsg='lsa --git'
alias ls_ext='lsa -s extension'
alias ls_mod='lsa -s modified'
alias ls_siz='lsa -s size'

alias startx="/usr/X11/bin/startx &"
alias tclsh="rlwrap tclsh"

alias xclock="xclock -d -brief -render -bg navy -fg white -chime -twelve  &"
alias Top='top -ocpu -O+rsize -n 30'
alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"

alias gitlogall='git log --since="8 days ago" --no-merges -p --author=rafferty'
alias gitlog='git log --since="8 days ago" --no-merges --oneline --author=rafferty'

alias slime='open -a "Sublime Text 2"'

alias alt_vpn='sudo cat $ALT_VPN_CRED | sudo openconnect 12.232.154.162 --servercert pin-sha256:/85a0ULOHRzG4modZMrtwu8/gA2IzmOVKsYCA3bXC7Q= --authgroup WKfrmHM -u trafferty --passwd-on-stdin'
alias hibernate='sudo ~/bin/hibernate.sh'
alias bye='tmutil stopbackup && diskutil unmountDisk /dev/disk2'
alias hi='diskutil mount /dev/disk2s2 && diskutil mount /dev/disk2s3 && diskutil mount /dev/disk2s4'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# User specific aliases and functions
alias remake="make clean && make -j4 && make install"
alias remaked="make clean && make debug && make install"
alias psf='ps -ef | grep $1'
alias Top='top -ocpu -O+rsize -n 30'
alias check_so="nm -d"

alias ant="ant -Dim30i=true -Dskipobfuscate=true -DlowSecurity=true"

alias cds='cd ~/src'

alias vnc="sudo java -jar ~/bin/tightvnc/tightvnc-jviewer.jar"
# cnt
alias cdi="cd $MII_HOME/src_imgAPO"
aLias cdd="cd $MII_HOME/src_dif_branch"
alias cdg="cd $MII_HOME/src/gui200"
alias cdw="cd $MII_WKSP"
alias cnt_ip="ifconfig | grep '10\.0\.'"

alias ssh2='ssh -oKexAlgorithms=+diffie-hellman-group1-sha1'
alias scp2='scp -oKexAlgorithms=+diffie-hellman-group1-sha1'

alias medis="cd ~/src/github/medis && npm run electron"
alias redis_gui="cd ~/src/github/medis && npm run electron"
alias branches="python ~/src/github/utils/python/branches.py"

alias jupyterlab='ulimit -n 4096 && cd ~/data && source ~/venv/data/bin/activate && jupyter lab'
alias godata='source ~/venv/data/bin/activate'

## Docker aliases
# stop and rm all containers:
alias docker_stop_and_rm_all='docker ps -aq | xargs docker rm -f'
# Kill all running containers.
alias docker_killall='docker kill $(docker ps -q)'
# Delete all stopped containers.
alias docker_cleanc='printf "\n>>> Deleting stopped containers\n\n" && docker rm $(docker ps -a -q)'
# Delete all untagged images.
alias docker_cleani='printf "\n>>> Deleting untagged images\n\n" && docker rmi $(docker images -q -f dangling=true)'
# Delete all stopped containers and untagged images.
alias docker_clean='dockercleanc || true && dockercleani'
