PROMPT='%{$fg_bold[green]%}%n@%m ' # username@host
PROMPT=${PROMPT}'%{$fg[cyan]%}%C ' # current dir
PROMPT=${PROMPT}'%{$reset_color%}$(git_prompt_info) ' # git stuff
PROMPT=${PROMPT}'%{$fg_bold[green]%}%# %{$reset_color%}' # prompt status and reset to normal color for command

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}!"
ZSH_THEME_GIT_PROMPT_CLEAN=""
