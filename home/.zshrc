# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="elias"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git django python pip virtualenvwrapper archlinux)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/cuda-toolkit/bin:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/echobravo/Games/bin

export LANG='en_US.UTF-8'

export EDITOR='vim'
export PAGER='less'

export NOOUT='/dev/null'

alias ls='ls --color=auto'
alias la="ls -A"
alias ll="ls -l"
alias lla="ls -lA"

alias cu="cd .."
alias cb="cd -"

alias lunit="/home/echobravo/Programming/lunit-0.5/lunit -p '/home/echobravo/Programming/lunit-0.5/?.lua' "
alias lunitjit="/home/echobravo/Programming/lunit-0.5/lunit -p '/home/echobravo/Programming/lunit-0.5/?.lua' -i '/usr/bin/luajit'"

alias wicd-curses='wicd-curses && clear'

alias iluajit2="luajit -e\"package.path=package.path..';/home/echobravo/Programming/ILuaJIT/?.lua'\"  /home/echobravo/Programming/ILuaJIT/iluajit.lua"

alias wcsnapshot="mplayer tv:// -tv driver=v4l2:width=640:height=480:device=/dev/video0 -fps 15 -vf screenshot"

alias i3lock="i3lock -c 000000"

source /home/echobravo/Programming/git-completion.bash

alias vbox="vbox 2>/dev/null &"

alias clip='xclip -sel clip'

alias okular="okular 2>$NOOUT"

# ---- Beginning of project stuff ----

# ---- YMSIM ----
export YMSIM='/home/echobravo/Projects/YMSim'
alias cdymsim="cd $YMSIM"

#--------------------SIEVE-----------------
source $(which virtualenvwrapper.sh)


# ---- End of project stuff ----
