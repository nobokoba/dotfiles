### AutoCompete
setopt correct auto_pushd auto_cd
setopt cdable_vars
setopt listpacked
autoload zed
stty stop undef
setopt ignoreeof

### History
setopt hist_ignore_dups histnostore extended_history hist_reduce_blanks
setopt inc_append_history share_history

# :とかｎメタ文字を使えるように
setopt nonomatch

# カッコの自動補完
setopt auto_param_keys
# ディレクトリスラッシュの自動補完
setopt auto_param_slash

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

### Aliases
alias ll='ls -l'
alias la='ls -a'

### keybind
bindkey -e
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
bindkey "^R" history-incremental-search-backward
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line

autoload -Uz zmv
alias zmv='noglob zmv -W'

### for TMUX
function tmux-quad-pane() {
    tmux split-window -v
    tmux split-window -v
    tmux split-window -v
    tmux select-layout tiled
    tmux select-pane -t 0
}

# Prompt
PROMPT='%n %% '
PROMPT2="%_%% "

setopt prompt_subst
autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null

zmodload zsh/regex
function rprompt-git-current-branch {
  local name st color gitdir action
  if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
    return
  fi
  name=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
  if [[ -z $name ]]; then
    return
  fi

  gitdir=`git rev-parse --git-dir 2> /dev/null`
  action=`VCS_INFO_git_getaction "$gitdir"` && action="($action)"

  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    color=%F{green}
  elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
    color=%F{yellow}
  elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
    color=%B%F{red}
  else
     color=%F{red}
  fi
  echo "$color$name$action%f%b "
}

export LANG=ja_JP.UTF-8
export XDG_CONFIG_HOME=~/.config

RPROMPT='`rprompt-git-current-branch` %~'

export EDITOR=vim
export SVN_EDITOR=vim
alias ls="ls -G"

fpath=(/usr/local/share/zsh-completions $fpath)
autoload -U compinit
compinit

# rbenv
eval "$(rbenv init -)"

# zplug
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh
zstyle :zplug:tag depth 1

zplug "zsh-users/zsh-completions"
zplug "felixr/docker-zsh-completion"
zplug "zsh-users/zsh-autosuggestions"

# Set the priority when loading
# e.g., zsh-syntax-highlighting must be loaded
# after executing compinit command and sourcing other plugins
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose

# brew cask
if [ -f $(brew --prefix)/etc/brew-wrap ];then
  source $(brew --prefix)/etc/brew-wrap
fi
