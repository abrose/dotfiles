# Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.volta/bin:$HOME/bin:$HOME/.local/bin:/usr/local/bin:/opt/homebrew/bin/cwebp:${KREW_ROOT:-$HOME/.krew}/bin:/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH

# Automatically start tmux
ZSH_TMUX_AUTOSTART=true  # Set to true if you want tmux to start automatically

# Automatically connect to a previous session if it exists
ZSH_TMUX_AUTOCONNECT=true

# Automatically close the terminal when tmux exits
ZSH_TMUX_AUTOQUIT=false

# Set the tmux config file location
ZSH_TMUX_CONFIG="$HOME/.tmux.conf"

# Tmuxinator
source ~/.bin/tmuxinator.zsh
export TMUXINATOR_CONFIG="$HOME/.config/tmuxinator"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

# AWS SETTINGS
export AWS_DEFAULT_REGION="eu-central-1"


# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  gitfast
  aws
  docker
  kubectl
  tmux
  aws-param # procure.ai
  prc-service # procure.ai
  prc-secret # procure.ai
  prc-customers-sync # procure.ai
  py-dep-update # procure.ai
)

source $ZSH/oh-my-zsh.sh

export ZPLUG_HOME=/opt/homebrew/opt/zplug

source $ZPLUG_HOME/init.zsh

zplug "mafredri/zsh-async", from:github
#zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
zplug "zdharma/fast-syntax-highlighting", as:plugin, defer:2
#zplug "zsh-users/zsh-autosuggestions", as:plugin, defer:2
zplug "popstas/zsh-command-time", as:plugin

zplug load
# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi


# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

export EDITOR='nvim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

GIT_COMPLETION_CHECKOUT_NO_GUESS=1
GIT_COMPLETION_SHOW_ALL=1

# Custom git autocompletion helpers
# See: https://www.reddit.com/r/zsh/comments/ass2tc/gitadd_completion_with_full_paths_listed_at_once/
_git_status_files () {
 local -a status_files=( ${"${(0)"$(git status -z)"}"} )
 local -a unstaged_files
 local -a staged_files
for entry in ${status_files}; do
   local stts=$entry[1,3]
   local file=$entry[4,-1]

   if [[ $stts[2] != ' ' ]]
   then
     unstaged_files+=$file
   fi
    if [[ $stts[1] != ' ' ]] && [[ $stts[1] != '?' ]]
    then
      staged_files+=$file
    fi
  done

  _describe -t unstaged 'Unstaged' unstaged_files && ret=0
  _describe -t staged 'Staged' staged_files && ret=0

  return $ret
}

__git_staged_files () {
  local -a staged_files=( ${"${(0)"$(git diff-index -z --name-only --no-color --cached HEAD)"}"} )
  _describe -t staged 'Staged files' staged_files && ret=0
  return $ret
}

__git_modified_files () {
  __git_status_files
}

__git_treeish-to-index_files () {
  __git_staged_files
}

__git_other_files () {
}

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias st="git status"
alias gsm="git switch main"
alias rr="ranger"
alias ll="ls -la"
alias vim="nvim"
alias awsp="source _awsp"
alias top="btm"

# Pyenv initialization
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Init fzf
source <(fzf --zsh)

source $HOME/.docker/init-zsh.sh || true # Added by Docker Desktop

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

#n JDK
export JAVA_HOME=$HOME/OpenJDK/jdk-20.0.2.jdk/Contents/Home

export PATH=$JAVA_HOME/bin:$PATH

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


[[ -f "$HOME/fig-export/dotfiles/dotfile.zsh" ]] && builtin source "$HOME/fig-export/dotfiles/dotfile.zsh"


# Added by LM Studio CLI (lms)
export PATH="$PATH:$HOME/.cache/lm-studio/bin"

eval "$(gh copilot alias -- zsh)"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Disabled to prevent interference with zsh-autocomplete
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=($HOME/.docker/completions $fpath)
autoload -U +X compinit
compinit
# End of Docker CLI completions

# IMPORTANT: Completion menu keybindings must come AFTER compinit
zmodload zsh/complist
setopt menu_complete
zstyle ':completion:*' menu select

# Arrow key bindings - using the exact codes from cat -v
bindkey -M menuselect '^[[A' up-line-or-history           # Up
bindkey -M menuselect '^[[B' down-line-or-history         # Down
bindkey -M menuselect '^[[C' forward-char                 # Right
bindkey -M menuselect '^[[D' backward-char                # Left


# Direnv hook
eval "$(direnv hook zsh)"

# Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
