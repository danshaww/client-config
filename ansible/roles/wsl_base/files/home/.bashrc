# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    if [ "$(whoami)" == root ]; then
    PS1="\[\e[38;5;160;1m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "
    else
    PS1="\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w\[\033[33m\]\$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/')\[\033[00m\] $ "
    fi
else
    PS1='\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# oh-my-posh
if [ -f ~/.oh_my_posh ]; then
    . ~/.oh_my_posh
fi

# Aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias nf=neofetch
alias powershell="powershell.exe && title $USER@$HOSTNAME"
alias pwsh="powershell.exe && title $USER@$HOSTNAME"
alias winget="powershell.exe winget && title $USER@$HOSTNAME"
alias ipconfig="powershell.exe ipconfig && title $USER@$HOSTNAME"
alias c=clear
alias q=exit
alias of=onefetch
alias j=just
alias k=kubectl
alias pbcopy="xclip -sel clip"
alias x="xclip -sel clip"
alias g="git status"
alias gu="~/git/client-config/scripts/repos.sh"

# Set Power Mode to High Performance
alias phigh="powershell.exe 'powercfg /setactive SCHEME_MIN' && title $USER@$HOSTNAME"
# Set Power Mode to Balanced
alias pmid="powershell.exe 'powercfg /setactive SCHEME_BALANCED' && title $USER@$HOSTNAME"
# Set Power Mode to Power Saver
alias plow="powershell.exe 'powercfg /setactive SCHEME_MAX' && title $USER@$HOSTNAME"
# Get Power Mode
alias pget="powershell.exe 'powercfg /getactivescheme' && echo '' && title $USER@$HOSTNAME"


# Custom Functions
gcm() {
    #git commit function
    git add .
    git commit -am "$*"
    git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)
}

gnb() {
    #git new branch function
    git switch main
    git pull
    git branch "$1"
    git switch "$1"
}

gmb() {
    #git switch main function
    git switch main
    git pull
}

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

title()
{
   # change the title of the current window or tab
   echo -ne "\033]0;$*\007"
}

ssh()
{
   /usr/bin/ssh "$@"
   # revert the window title after the ssh command
   title $USER@$HOSTNAME
}

rdp()
{
   powershell.exe mstsc.exe /v: "$@"
   # revert the window title after the ssh command
   title $USER@$HOSTNAME
}

export EDITOR='code --wait -r'
export PATH=$PATH:$HOME/.tfenv/bin
# export ANSIBLE_VAULT_PASSWORD_FILE=~/.vault

[[ "$PWD" == "$HOME" ]] && cd "$HOME/git"

title $USER@$HOSTNAME
eval "$(starship init bash)"