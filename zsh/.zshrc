# Direnv hook - must be before P10k instant prompts initialization
eval "$(direnv hook zsh)"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH=$HOME/.volta/bin:$HOME/bin:$HOME/.local/bin:/usr/local/bin:/opt/homebrew/bin/cwebp:${KREW_ROOT:-$HOME/.krew}/bin:/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH


# Set the tmux config file location
ZSH_TMUX_CONFIG="$HOME/.tmux.conf"

# Tmuxinator
source ~/.bin/tmuxinator.zsh
export TMUXINATOR_CONFIG="$HOME/.config/tmuxinator"

# Tmux session switcher with preview
tms() {
    # If not in tmux, start/attach session
    if [ -z "$TMUX" ]; then
        # Get all sessions
        session=$(tmux list-sessions -F "#{session_name}: #{session_windows} windows #{?session_attached,(attached),}" 2>/dev/null | fzf --height 40% --reverse --prompt="Select session: ")
        
        if [ -n "$session" ]; then
            session_name=$(echo $session | cut -d: -f1)
            tmux attach -t "$session_name"
        fi
    else
        # If in tmux, switch to selected session
        session=$(tmux list-sessions -F "#{session_name}: #{session_windows} windows #{?session_attached,(attached),}" | fzf --height 40% --reverse --prompt="Switch to session: ")
        
        if [ -n "$session" ]; then
            session_name=$(echo $session | cut -d: -f1)
            tmux switch-client -t "$session_name"
        fi
    fi
}

# Quick session jump with preview of windows
tmux-jump() {
    if [ -z "$TMUX" ]; then
        echo "Not in a tmux session"
        return 1
    fi
    
    local session=$(tmux list-sessions -F "#{session_name}" | \
        fzf --preview 'tmux list-windows -t {} -F "  #{window_index}:#{window_name} (#{window_panes} panes)"' \
            --preview-window right:40% \
            --header "Current: $(tmux display-message -p '#S')" \
            --prompt "Jump to session: ")
    
    if [ -n "$session" ]; then
        tmux switch-client -t "$session"
    fi
}

# Send a command to all active panes in all sessions and windows
tmux-all() {
  local cmd="${1:?Usage: tmux-all 'command'}"
  for pane in $(tmux list-panes -a -F '#{session_name}:#{window_index}.#{pane_index}'); do
    tmux send-keys -t "$pane" C-c
    tmux send-keys -t "$pane" "$cmd" Enter
  done
}

# Bind to alias for quick access
alias tj='tmux-jump'
alias ts='tms'

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
ZSH_THEME="powerlevel10k/powerlevel10k"

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
  tmuxinator
  aws-param # pai
  prc-service # pai
  prc-secret # pai
  prc-customers-sync # pai
  py-dep-update # pai
  fast-syntax-highlighting
  fzf-zsh-plugin
  fzf-tab
)

source $ZSH/oh-my-zsh.sh

# User configuration

# fzf-tab configuration
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# custom fzf flags
# NOTE: fzf-tab does not follow FZF_DEFAULT_OPTS by default
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
# To make fzf-tab follow FZF_DEFAULT_OPTS.
# NOTE: This may lead to unexpected behavior since some flags break this plugin. See Aloxaf/fzf-tab#455.
zstyle ':fzf-tab:*' use-fzf-default-opts yes
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'

# Default editor
export EDITOR='nvim'

# git-machete default editor
export GIT_MACHETE_EDITOR='nvim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

GIT_COMPLETION_CHECKOUT_NO_GUESS=1
GIT_COMPLETION_SHOW_ALL=1

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="vim ~/.zshrc"
alias zshreload="source ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias st="git status"
alias gsm="git switch main"
alias rr="ranger"
alias ll="ls -la"
 alias cd="z"
alias vim='NVIM_APPNAME=nvim-lazyvim nvim' 
alias awsp='awsswitch; sp="$(cat ~/.awsswitch)"; if [ -z "$sp" ]; then unset AWS_PROFILE; else export AWS_PROFILE="$sp" && k ctx $(k ctx | grep $(cat ~/.awsswitch));fi'
alias top="btm"
alias mux="tmuxinator"
alias txs="tmuxinator start"
alias txe="tmuxinator edit"
alias txl="tmuxinator list"
alias txd="tmuxinator delete"

alias fuck="git clean -fd && git restore ."

alias claudify="$HOME/workspace/claude-container/run-claude.sh"

# Git worktree helper functions
# gwa - git worktree add
# usage: gwa feat/APP-100-feature origin/main
gwa() {
  local branch="$1"
  local base="${2:-HEAD}"
  local dir="../${branch//\//-}"
  git worktree add -b "$branch" "$dir" "$base"

  # Symlink machete file if it exists
  local bare_dir="$(git rev-parse --git-common-dir)"
  local wt_name="${branch//\//-}"
  if [[ -f "$bare_dir/machete" ]]; then
    ln -s "$bare_dir/machete" "$bare_dir/worktrees/$wt_name/machete" 2>/dev/null
    echo "Machete symlinked. Run 'git machete edit' to add '$branch' to the stack."
  fi
}

# gwc - git worktree checkout
# usage:
# gwc feat/APP-100-feature

gwc() {
  local branch="$1"
  local dir="../${branch//\//-}"
  git worktree add "$dir" "$branch"
}


# Pyenv initialization
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Init fzf
# Regenerate if fzf binary is newer than the cache
# if [[ ! -f ~/.fzf.zsh || $(which fzf) -nt ~/.fzf.zsh ]]; then
#   fzf --zsh > ~/.fzf.zshfi
# fi
#   source ~/.fzf.zsh

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


# Added by LM Studio CLI (lms)
export PATH="$PATH:$HOME/.cache/lm-studio/bin"

# eval "$(gh copilot alias -- zsh)"
ghcs() { unset -f ghcs ghce; eval "$(gh copilot alias -- zsh)"; ghcs "$@"; }
ghce() { unset -f ghcs ghce; eval "$(gh copilot alias -- zsh)"; ghce "$@"; }

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



# Custom interactive search using ripgrep and fzf
vg() {
  rg -F --color=always --line-number "$1" | \
    fzf --ansi --exact --delimiter ':' \
        --preview 'bat --color=always {1} --highlight-line {2}' \
        --preview-window '+{2}-10' \
        --bind 'enter:execute(nvim {1} +{2})' \
        --bind 'ctrl-o:become(nvim {1} +{2})'
}

# Override aws_prompt_info with profile and region
function aws_prompt_info() {
  local _aws_profile="${AWS_PROFILE:-${AWS_DEFAULT_PROFILE:-default}}"
  local _aws_region="${AWS_DEFAULT_REGION:-${AWS_REGION:-us-east-1}}"

  if [[ -n "$_aws_profile" ]]; then
    echo "%{$fg[yellow]%}☁️  %{$fg[magenta]%}${_aws_profile}%{$fg[dim]%}/%{$fg[cyan]%}${_aws_region}%{$reset_color%}"
  fi
}

###################################
# Customer Project related stuff
#

# ProcureAi

# Required for the weasyprint lib

## END of Customer related stuff
###################################


eval "$(zoxide init zsh)"
# eval "$(atuin init zsh --disable-up-arrow)"

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# Added by LM Studio CLI (lms)
export PATH="$PATH:$HOME/.cache/lm-studio/bin"
# End of LM Studio CLI section

# Vi mode
bindkey -v
export KEYTIMEOUT=1

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
