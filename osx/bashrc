export DISPLAY=localhost:0.0
export COMPUTERNAME=THR_MBP
alias xemacs="xemacs -fg darkblue -bg white"

alias ls="ls -G"
alias lsa="ls -alhF"
alias ls1="ls -1"

alias cdb="cd /Users/traff_ss/Dropbox/work/briggo"
alias cdm="cd /Users/traff_ss/src/briggo/kiosk/master_controller"
alias briggomt='cd ~/src/briggo/engineering/trunk/common/scripts/python && ./briggomt.py -i 10.128.1.5'

alias gastro="ssh rafferty@astro"
alias backitup="source ~/backitup.sh"
alias point="source ~/src/HET/point/bin/teldef-het.sh raw"
alias psf="source ~/psf.sh"
#alias clam="grep -A 10 'SCAN SUMMARY' ~/Library/Logs/clamXav-scan*.*"
alias clam="tail -n 45 ~/Library/Logs/clamXav-scan.log"

alias startx="/usr/X11/bin/startx &"
alias tclsh="rlwrap tclsh"

alias xclock="xclock -d -brief -render -bg navy -fg white -chime -twelve  &"
alias octave="exec '/Applications/misc/Octave.app/Contents/Resources/bin/octave'"

alias truetime="screen -T vt100 /dev/tty.usbserial-ftDDI226 9600"
alias Top='top -ocpu -O+rsize -n 30'

alias gitlogall='git log --since="8 days ago" --no-merges -p --author=rafferty'
alias gitlog='git log --since="8 days ago" --no-merges --oneline --author=rafferty'

alias slime='open -a "Sublime Text 2"'

export PATH=/usr/local/lib:/usr/local/bin:/opt/local/bin:/opt/local/sbin:$PATH
export MANPATH=/opt/local/share/man:$MANPATH

export EDITOR=/usr/bin/edit

#function git_branch {
#  ref=$(git symbolic-ref HEAD 2>/dev/null) || return
#  echo " ("${ref#refs/heads/}")"
#}

# Set git autocompletion and PS1 integration
#if [ -f /usr/local/bin/git/contrib/completion/git-completion.bash ]; then
#  . /usr/local/bin/git/contrib/completion/git-completion.bash
#fi
# 
# These are the lines that work for git installed from homebrew:
if [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
  . /usr/local/etc/bash_completion.d/git-completion.bash
fi
if [ -f /usr/local/etc/bash_completion.d/git-prompt.sh ]; then
  . /usr/local/etc/bash_completion.d/git-prompt.sh
fi
GIT_PS1_SHOWDIRTYSTATE=true

#if [ -f /opt/local/etc/bash_completion ]; then
#    . /opt/local/etc/bash_completion
#fi

# prompt that is usable
#PS1=$'\\[\\033]0;\\w\\007\n\\033[32m\\]\\u@\\h \\[\\033[33m\\w\\033[0m\\]\n$ '
#PS1=$'\\[\\033]0;\\w\\007\n\\033[32m\\]\\u@\\h \\[\\033[33m\\w\\033[0m\\]\\[\\033[0;32m\\]$(git_branch)\\033[0m\\]\n$ '
PS1=$'\\[\\033]0;\\w\\007\n\\033[32m\\]\\u@\\h \\[\\033[33m\\w\\033[0m\\]\\[\\033[0;34m\\]$(__git_ps1)\\033[0m\\]\n$ '
PS2='> '
PS4='+ '

# set colors for ls (see bash_term_colors.txt)
export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacae

#
# HET2 Dev Setup
#
HET2_DEPLOY=~/deploy
HET2_WKSP=~/src/HET2
HET2_AUXIL=$HET2_WKSP/auxil
export HET2_DEPLOY HET2_WKSP HET2_AUXIL

LD_LIBRARY_PATH=\
$SWIG_ROOT/share:\
$SLALIB_ROOT:\
$LD_LIBRARY_PATH

#PATH=\
#/usr/local/bin:\
#/usr/local/share/python:\
#$PATH

export PATH LD_LIBRARY_PATH MANPATH

export BACKUP_ROOT=~/Documents/work/UT
export BACKUP_FROM_LOG=~/tmp/gs_backup/backupFromlog
export BACKUP_TO_LOG=~/tmp/gs_backup/backupTolog
export BOTO_RSYNC=/usr/local/share/python/boto-rsync
alias backupToGS="~/Dropbox/work/gs/backupToGS.sh"
alias backupFromGS="~/Dropbox/work/gs/backupFromGS.sh"
#/Library/Frameworks/Python.framework/Versions/Current/bin/boto-rsync

alias cdh="cd $HET2_WKSP/"
alias cdc="cd $HET2_WKSP/common/"
alias cda="cd $HET2_WKSP/auxil/"
alias cdg="cd $HET2_WKSP/gui/"
alias cdt="cd $HET2_WKSP/tcs/"
alias cdp="cd $HET2_WKSP/pfip/"
alias cdpa="cd $HET2_WKSP/pas/"

alias trackersim="tclsh $HET2_WKSP/sim/TrackerSim/tcl/testServer2.tcl"
alias branch="$HET2_WKSP/InHouse/gitTools/branches.py"

# --------------------------------------

#MKL_NUM_THREADS=1
#export MKL_NUM_THREADS

function lk(){ grep -i $1 ~/Albums.txt; }
