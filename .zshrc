## completion {{{
autoload -U compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
compinit
## completion }}}

## histroy {{{
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=100000
setopt hist_ignore_dups
setopt EXTENDED_HISTORY
## histroy }}}

setopt extended_glob
setopt noflowcontrol

## key binding {{{
bindkey -v
bindkey '^R' history-incremental-search-backward
bindkey '^Q' push-line-or-edit
## key binding }}}

## prompt {{{
colh="%{[36m%}"
case ${UID} in
0)
    PROMPT="%B%{[31m%}%/#%{[m%}%b "
		PROMPT2="%B%{[31m%}%_#%{[m%}%b "
		SPROMPT="%B%{[31m%}%r is correct? [n,y,a,e]:%{[m%}%b "
		;;
*)
		PROMPT="${colh}${USER}@%m:%1~ >%{[m%}"
		RPROMPT="%{[33m%}[%~]%{[m%}"
		PROMPT2="%{[35m%}%_%%%{[m%} "
		SPROMPT="%{[31m%}%r is correct? [n,y,a,e]:%{[m%} "
		;;
esac
## prompt }}}

## aliases {{{
alias ls="ls -G"
alias ll="ls -la"
#alias git-delete-pruned-branch="git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -d"
alias git-delete-pruned-branch="grep -e '\[deleted\]' | awk '{print $5}' | sed 's/^origin\///' | xargs git branch --delete"

## aliases }}}

[ -f "$HOME"/.zshrc.local ] && source $HOME/.zshrc.local

export LC_CTYPE=ja_JP.UTF-8

export PATH="$HOME/.yarn/bin:$PATH"
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}
