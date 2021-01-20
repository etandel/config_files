## etandel
#
# vim:ft=zsh ts=2 sw=2 sts=2

# Must use Powerline font for \uE0A0 to render.

# A fusion of "amuse" and "bira" themes

ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}\uE0A0 "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_RUBY_PROMPT_PREFIX="%{$fg_bold[red]%}‹"
ZSH_THEME_RUBY_PROMPT_SUFFIX="›%{$reset_color%}"

if [[ $UID -eq 0 ]]; then
    local user_host='%{$terminfo[bold]$fg[red]%}%n@%m %{$reset_color%}'
    local user_symbol='#'
else
    local user_host='%{$terminfo[bold]$fg[green]%}%n@%m %{$reset_color%}'
    local user_symbol='$'
fi

local dirinfo='%{$fg_bold[green]%}%~%{$reset_color%}'
local gitinfo='$(git_prompt_info)'
local datetimeinfo='⌚ %{$fg_bold[red]%}%D %*%{$reset_color%}'

PROMPT="╭─${user_host} ${dirinfo} ${gitinfo} ${datetimeinfo}
╰─${user_symbol} "

RPROMPT='$(ruby_prompt_info)'
