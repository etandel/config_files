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

WORKON_HOME=$HOME/.virtualenvs

export GOPATH="$HOME/go"
export PYENV_ROOT="$HOME/proj/pyenv"

plugins=(git git-flow django python pip virtualenvwrapper pyenv archlinux lua luarocks rust cargo go golang kubectl helm)

source $ZSH/oh-my-zsh.sh

fpath+="~/.zfunc"

export PATH="$PYENV_ROOT/bin:~/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/cuda-toolkit/bin:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/echobravo/Games/bin:$GOPATH/bin"

export LANG='en_US.UTF-8'

export EDITOR='vim'
export PAGER='less'

export NOOUT='/dev/null'

alias ls='ls --color=auto'
alias la="ls -A"
alias ll="ls -l"
alias lla="ls -lA"

alias wicd-curses='wicd-curses && clear'

alias wcsnapshot="mplayer tv:// -tv driver=v4l2:width=640:height=480:device=/dev/video0 -fps 15 -vf screenshot"

alias i3lock="i3lock -c 000000"

alias vbox="vbox 2>/dev/null &"

alias clip='xclip -sel clip'

alias pycharm="echo -e \n | /opt/pycharm/bin/pycharm.sh"

alias untar="tar xvf"

alias vim=gvim

alias -g -- '--foda-se=--force'


# change backlight to $1 * 100
chlight(){
    if [[ -n $1 ]]; then
        local val=$(lua -e "print(math.floor(100 * $1))")
        sudo tee /sys/class/backlight/intel_backlight/brightness <<< $val
    else
        cat /sys/class/backlight/intel_backlight/brightness
    fi
}

# manopt cmd opt -> prints the -opt description from `man cmd` 
manopt(){
    man $1 | sed 's/.\x08//g'| sed -n "/^\s\+-\+$2\b/,/^\s*$/p" | sed '$d;';
}

#xgh quote of the day
xghfortune(){
    if [[ -f $1 ]]; then
        cat $1
    else
        curl -s 'http://xgh.herokuapp.com/' | w3m -T text/html | grep '^[0-9]\+\-'
    fi | sort -R | head -n 1
}

#quote xgh if it's a login shell
if [[ -o login ]]; then
    echo "\nXGH quote of the the day: \"$(xghfortune /usr/local/share/xghquotes.txt)\""
fi


git-delete() { git branch -d $1 && git push origin :$1 }


mkpymod () {
	mkdir -p $1 && touch $1/__init__.py
}


clipclr() {
    echo | clip
    echo | clip -sel prim
}

switchnetwork() {
    if netctl list | fgrep '* cell' >/dev/null; then
        sudo netctl switch-to casa
    else
        sudo netctl switch-to cell
    fi
}


git-chg-date() {
    YEAR="$1"
    MONTH="$2"
    DAY="$3"
    TIME="$4"
    DATE="$MONTH $DAY $TIME:${(l:2::0:)$(shuf -i 1-59 -n 1)} $YEAR -0300"
    GIT_COMMITER_DATE="$DATE" git commit --amend --date="$DATE"
}

count-words() {
    sed 's/[\/.,]/ /g' $@ | wc -w
}

# don't let python create __pycache__ or pyc files
export PYTHONDONTWRITEBYTECODE=1

#source ~/proj/luarocks-venv/lvenv.sh


# ---- Beginning of project stuff ----

ONYO_RC=~/onyo/src/onyorc.sh

if [[ -f $ONYO_RC ]]; then
    source $ONYO_RC
fi

# ---- End of project stuff ----
