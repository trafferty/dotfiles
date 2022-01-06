# export DISPLAY=localhost:0.0
# export COMPUTERNAME=THR_MBP

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it

# Save and reload the history after each command finishes
#export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
# turn off shell history copying
alias solo='unset PROMPT_COMMAND'

# homebrew path add:
export PATH=/usr/local/lib:/usr/local/bin:/usr/local/sbin:/opt/local/bin:/opt/local/sbin:$PATH
# thr path add:
export PATH=$HOME/bin:$PATH
export PATH="/usr/local/opt/tcl-tk/bin:$PATH"

export MANPATH=/opt/local/share/man:$MANPATH
export PATH LD_LIBRARY_PATH MANPATH

export EDITOR=/usr/bin/vim

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
GIT_PS1_SHOWDIRTYSTATE=true

# prompt that is usable
#PS1=$'\\[\\033]0;\\w\\007\n\\033[32m\\]\\u@\\h \\[\\033[33m\\w\\033[0m\\]\n$ '
#PS1=$'\\[\\033]0;\\w\\007\n\\033[32m\\]\\u@\\h \\[\\033[33m\\w\\033[0m\\]\\[\\033[0;32m\\]$(git_branch)\\033[0m\\]\n$ '
#PS1=$'\\[\\033]0;\\w\\007\n\\033[34m\\]\\u@\\h \\[\\033[33m\\w\\033[0m\\]\\[\\033[0;34m\\]$(__git_ps1)\\[\\033[0m\\]\n$ '
#PS1=$'\\[\\033]0;\\w\\007\n\\033[34m\\]\\u@\\h\\[\\033[0;32m\\]$ANACONDA \\[\\033[33m\\w\\033[0m\\]\\[\\033[0;34m\\]$(__git_ps1)\\[\\033[0m\\]\n$ '
PS1=$'\\[\\033]0;\\w\\007\n\\033[34m\\]\\u@\\h\\[\\033[0;32m\\] ($CONDA_DEFAULT_ENV) \\[\\033[33m\\w\\033[0m\\]\\[\\033[0;34m\\]$(__git_ps1)\\[\\033[0m\\]\n$ '
PS2='> '
PS4='+ '

# set colors for ls (see bash_term_colors.txt)
export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacae

# CNT
export MII_AUXIL=~/dev/src/auxil
export MII_WKSP=~/workspace
export MII_HOME=~/dev
export ALT_VPN_CRED=~/tmp/bt/alt_vpn_pw

# GUI build:
export PATH=$MII_HOME/src/gui200/tools/apache-ant/bin:$PATH
export ANT_HOME=/Users/trafferty/dev/src/gui200/tools/apache-ant/bin/ant
#export JAVA_HOME=~/dev/src/openjdk
export JAVA_HOME=$(/usr/libexec/java_home)
export TCLSH=/usr/bin/tclsh

# setup env var for jupyter notebook helper
export DATA_ROOT=/Users/trafferty/data

export BASH_SILENCE_DEPRECATION_WARNING=1

hgrep() { history | grep "$@"; }

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/ssh_aliases.sh ]; then
    . ~/ssh_aliases.sh
fi

#export NO_CONDA_PATH=$PATH
. /Users/trafferty/anaconda/etc/profile.d/conda.sh
ana() {
    ## Enable Anaconda:
    # old way: export PATH=/Users/trafferty/anaconda/bin:$PATH
    conda activate base36
    #conda activate py38
    #export ANACONDA=' (conda)'
}
no_ana() {
    ## Enable Anaconda:
    # old way: export PATH=$NO_CONDA_PATH
    conda deactivate
    #unset ANACONDA
}
