# laan's bashrc.

# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything:
#[ -z "$PS1" ] && return

# Eternal bash history.
# ---------------------
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=
#export HISTTIMEFORMAT="[%F %T] kaka"
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups


export EDITOR=vim

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# enable color support of ls and also add handy aliases
if [[ "$TERM" != "dumb" ]]; then
    if [[ `uname` == "Darwin" ]]; then
        alias ls="ls -p -G" 
        export LS_COLORS='ex=01;37'
    else      
        eval "`dircolors -b`"
        alias ls='ls --color=auto'
    fi
fi

# some more ls aliases
alias ll='ls -l'
alias cvstat="cvs status | grep Status:"
alias la='ls -A'
alias l="less"
alias ssh="ssh -X"

# puppet aliases
alias pag='puppet agent'
alias ppv='puppet parser validate'

# git aliases
alias gst='git status'
alias gco='git commit'
alias gad='git add'
alias glg='git log'
alias gps='git push'
alias gpu='git pull'
alias gdf='git diff'

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" -a -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color)
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    ;;
*)
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    ;;
esac

# Comment in the above and uncomment this below for a color prompt
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

export PS1="\[\e[29;1m\]\h:\[\e[0m\]\W:>"

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
    ;;
*)
    ;;
esac

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profiles
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

if [[ `uname` == Darwin ]]; then 
    if [ -f /opt/local//share/git/contrib/completion/git-completion.bash ]; then
        source /opt/local//share/git/contrib/completion/git-completion.bash
    fi
    export PS1="\W:>"
fi
export LD_LIBRARY_PATH=""
export PATH=:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
if [ -e  /usr/local/cuda-8.0/ ]; then
    export PATH=$PATH:/usr/local/cuda-8.0/bin/
    export LD_LIBRARY_PATH=/usr/local/cuda-8.0/lib64
fi


if [ -e $HOME/.bashrc.local ]; then
    source $HOME/.bashrc.local 
fi


