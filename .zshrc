# Configuration
## Theming
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

## Editor
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

## Plugins
plugins=(git)

## Misc
setopt extendedglob


# Tools
## Homebrew
### Completion
[[ -f /home/linuxbrew/.linuxbrew/bin/brew ]] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"
[[ -f /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv zsh)"
if type brew &>/dev/null; then
  [[ -d $HOMEBREW_PREFIX/share/zsh-completions ]] && FPATH=$HOMEBREW_PREFIX/share/zsh-completions:$FPATH
  [[ -d $HOMEBREW_PREFIX/share/zsh/site-functions ]] && FPATH=$HOMEBREW_PREFIX/share/zsh/site-functions:$FPATH
  autoload -Uz compinit
  compinit
fi
### Config
source $ZSH/oh-my-zsh.sh
if [[ -f $HOMEBREW_PREFIX/share/powerlevel10k/powerlevel10k.zsh-theme ]]; then
  source $HOMEBREW_PREFIX/share/powerlevel10k/powerlevel10k.zsh-theme
  [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
fi
export NVM_DIR="$HOME/.nvm"
[[ -s $HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm ]] && \. $HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm  # This loads nvm bash_completion
alias nvm="unalias nvm; [[ -s $HOMEBREW_PREFIX/opt/nvm/nvm.sh ]] && \. $HOMEBREW_PREFIX/opt/nvm/nvm.sh; nvm $@"  # This loads nvm

## Babashka
### Autocomplete
_bb_tasks() {
    local matches=(`bb tasks |tail -n +3 |cut -f1 -d ' '`)
    compadd -a matches
    _files # autocomplete filenames as well
}
compdef _bb_tasks bb
### Global tasks
bb() {
  typeset -A BB_CONFIGS
  BB_CONFIGS=(
    catppuccin "$HOME/.config/catppuccin/bb.edn",
    notes "$HOME/Notes/bb.edn"
  )
  if [[ "$1" =~ '^([a-zA-Z0-9_-]+):(.+)$' ]]; then
    local key="${match[1]}"
    local task="${match[2]}"
    if [[ -n "${BB_CONFIGS[$key]}" ]]; then
      $HOMEBREW_PREFIX/bin/bb --config "${BB_CONFIGS[$key]}" "$task" "${@:2}"
      return
    fi
  fi
  $HOMEBREW_PREFIX/bin/bb "$@"
}

## Kubectl
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export XDG_CONFIG_HOME="$HOME/.config"
source <(kubectl completion zsh)


# Aliases
## Config
unsetopt complete_aliases

## General
alias vi='nvim'
alias vim='nvim'
alias filetree='tree'
alias dirtree='tree -d'

## Git
alias git-cleanup-merged='git fetch --prune && git branch --merged | egrep -v "master|develop" | xargs git branch -d'

## Tools
eval $(thefuck --alias)
alias loyctl='kubectl -n b2c-loyalty'
compdef loyctl='kubectl'
