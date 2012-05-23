#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#PS1='[\u@\h \W]\$ '
export PS1='\[\033[01;32m\]\u@\h \[\033[01;32m\]\W \$ \[\033[00m\]' #user and prompt light green

export LANG='en_US.UTF-8'

export EDITOR='vim'
export PAGER='less'

export NOOUT='/dev/null'

export PATH=$PATH:/home/echobravo/Games/bin

alias ls='ls --color=auto'
alias la="ls -a"
alias ll="ls -l"
alias lla="ls -la"

alias cls="cd "

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

# ---- Beginning of project stuff ----

export YMSIM='/home/echobravo/Projects/YMSim'
alias cdymsim="cd $YMSIM"

source /home/echobravo/Programming/tecgraf/tecmake/tec_uname.bsh

# ---- End of project stuff ----
