# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="robbyrussell"
ZSH_THEME="etandel"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

HYPHEN_INSENSITIVE="true"

ASDF_DIR='/opt/asdf-vm'

WORKON_HOME=$HOME/.virtualenvs

#export GOPATH="$HOME/go"
export PYENV_ROOT="$HOME/proj/pyenv"
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

export PATH="$HOME/.local/share/gem/ruby/2.7.0/bin:$HOME/.poetry/bin:$HOME/.cargo/bin:$HOME/.gvm/bin:$PYENV_ROOT/shims:$HOME/.local/bin:/usr/local/bin:/usr/games:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:"

plugins=(
    archlinux
    git
    python
    pip
    pyenv
    rust
    golang
    kubectl
    helm
    terraform
    aws
    docker
    docker-compose
    mix
    pass
    asdf
)

source $ZSH/oh-my-zsh.sh

unsetopt autocd

fpath+="~/.zfunc"


export LANG='en_GB.UTF-8'

export EDITOR='nvim'
export PAGER='less'
export LESS='--RAW-CONTROL-CHARS --quit-if-one-screen'

# use bat as man colorizer if it is installed
command -v bat >/dev/null 2>&1 && export MANPAGER="sh -c 'col -bx | bat -l man -p'"

export NOOUT='/dev/null'

alias ls='ls --color=auto'
alias la="ls -A"
alias ll="ls -l"
alias lla="ls -lA"

alias wcsnapshot="mplayer tv:// -tv driver=v4l2:width=640:height=480:device=/dev/video0 -frames 1 -vo jpeg"

alias i3lock="i3lock -c 000000"

alias vbox="vbox 2>/dev/null &"

alias clip='xclip -sel clip'

alias untar="tar xvf"

alias vim=nvim

alias ndvim="neovide --maximized"

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
#if [[ -o login ]]; then
#    echo "\nXGH quote of the the day: \"$(xghfortune /usr/local/share/xghquotes.txt)\""
#fi


git-delete() {
    git branch -d "$@" &&  \
        echo "$@" | xargs -n 1 git push --delete origin &&
}

git-delete-all-merged() {
    branches=$(git branch --me | \
        egrep -v 'master|develop|main|\*' | \
        tr '\n' ' '
    )
    git-delete ${=branches}

    git remote prune origin
}


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
    DATE="$MONTH $DAY $TIME:${(l:2::0:)$(shuf -i 1-59 -n 1)} $YEAR +0200"
    GIT_COMMITER_DATE="$DATE" git commit --amend --date="$DATE"
}

count-words() {
    sed 's/[\/.,]/ /g' $@ | wc -w
}

viclean() { find ${1:-.} -name '.*.sw?' -delete }


has_conflict() {
    rg '<<<|>>>|===='
}

alias frg='rg -F'

retry () {
	while ! $@
	do
		sleep 1
	done
}

rot13(){
    tr 'A-Za-z' 'N-ZA-Mn-za-m'
}

pass-push() {
    pass git push origin master
}

pass-pull() {
    pass git pull origin
}


alrm() {
  ( \speaker-test --frequency $1 --test sine )&
  pid=$!
  \sleep ${2}s
  \kill -9 $pid
}


# don't let python create __pycache__ or pyc files
export PYTHONDONTWRITEBYTECODE=1

#source ~/proj/luarocks-venv/lvenv.sh


# gvm
[[ -s "/home/etandel/.gvm/scripts/gvm" ]] && source "/home/etandel/.gvm/scripts/gvm"

# ---- Beginning of project stuff ----

FRAMENRC="$HOME/framen/src/framenrc.zsh"
[[ -s "$FRAMENRC" ]] && source "$FRAMENRC"

# ---- End of project stuff ----
