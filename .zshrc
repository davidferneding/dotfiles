# Configuration
## Theming
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
export ZSH="$HOME/.nix-profile/share/oh-my-zsh"
export ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/oh-my-zsh"
[[ -d $ZSH_CACHE_DIR/completions ]] || mkdir -p "$ZSH_CACHE_DIR/completions"
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
if [[ -f $HOME/.nix-profile/share/zsh-powerlevel10k/powerlevel10k.zsh-theme ]]; then
  source $HOME/.nix-profile/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
  [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
fi

## Nix
[[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]] && source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
[[ -f $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh ]] && source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
[[ -d $HOME/.nix-profile/bin ]] && path=($HOME/.nix-profile/bin $path)

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
    catppuccin "$HOME/.config/catppuccin/bb.edn"
    notes "$HOME/Notes/bb.edn"
  )
  if [[ "$1" =~ '^([a-zA-Z0-9_-]+):(.+)$' ]]; then
    local key="${match[1]}"
    local task="${match[2]}"
    echo "${BB_CONFIGS[$key]}"
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

## dotnet
export PATH="$PATH:$HOME/.dotnet/tools"

## rust
export PATH="$PATH:$HOME/.cargo/bin"


# Aliases
## Config
unsetopt complete_aliases

## General
alias vi='nvim'
alias vim='nvim'
alias filetree='tree'
alias dirtree='tree -d'

## Git
git-cleanup() {
  git fetch --prune --prune-tags --force || return
  git for-each-ref --format='%(refname:short) %(upstream:track)' refs/heads \
    | awk '$2 == "[gone]" && $1 !~ /^(main|master|develop)$/ {print $1}' \
    | xargs git branch -D
}
git-list-local() {
  git for-each-ref --format='%(refname:short) %(upstream)' refs/heads \
    | awk 'NF == 1 && $1 !~ /^(main|master|develop)$/ {print $1}'
}

## Tools
eval $(thefuck --alias)
alias loyctl='kubectl -n b2c-loyalty'
compdef loyctl='kubectl'
