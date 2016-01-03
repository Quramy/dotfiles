
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
## aliases }}}

[ -f "$HOME"/.zshrc.local ] && source $HOME/.zshrc.local
