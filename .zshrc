# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="powerlevel10k/powerlevel10k"

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
plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-completions)

source $ZSH/oh-my-zsh.sh

# User configuration

# Better history settings
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY

# Zsh autosuggestions styling
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#5f5f87'
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="$PATH:$HOME/.local/bin"

eval "$(starship init zsh)"

# Git alias to move last commit to a new branch from origin/main
alias git-move-commit='git_move_commit_to_new_branch'
git_move_commit_to_new_branch() {
  if [ -z "$1" ]; then
    echo "Usage: git-move-commit <new-branch-name>"
    return 1
  fi

  local new_branch="$1"
  local commit_sha=$(git rev-parse HEAD)
  local current_branch=$(git branch --show-current)

  echo "Moving commit $commit_sha from branch '$current_branch' to new branch '$new_branch'"
  echo ""

  # Reset current branch (remove the commit)
  git reset --hard HEAD~1

  # Fetch latest from origin
  git fetch origin

  # Create new branch from origin/main
  git checkout -b "$new_branch" origin/main

  # Cherry-pick the commit
  git cherry-pick "$commit_sha"

  echo ""
  echo "Done! Commit moved to new branch '$new_branch'"
  echo "You can now push with: git push -u origin $new_branch"
}

eval "$(fzf --zsh)"

# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# --- setup fzf theme (Tokyo Night inspired) ---
export FZF_DEFAULT_OPTS="
  --height 60%
  --layout=reverse
  --border rounded
  --preview-window 'right:60%:wrap'
  --info=inline
  --multi
  --color=fg:#c8d3f5,bg:#222436,hl:#ff966c
  --color=fg+:#c8d3f5,bg+:#2f334d,hl+:#ff966c
  --color=info:#82aaff,prompt:#86e1fc,pointer:#86e1fc
  --color=marker:#c3e88d,spinner:#c3e88d,header:#c3e88d
  --color=gutter:#222436,border:#589ed7
  --prompt='▶ '
  --pointer='◆'
  --marker='✓'"

# ---- Eza (better ls) -----
alias ls="eza --icons=always --group-directories-first"
alias ll="eza -l --icons=always --group-directories-first --git"
alias la="eza -la --icons=always --group-directories-first --git"
alias lt="eza --tree --level=2 --icons=always --group-directories-first"
alias lta="eza --tree --level=2 --icons=always --group-directories-first -a"
alias l="eza -lah --icons=always --group-directories-first --git --color=always"

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"
# alias cd="z"

# ---- Better aliases ----
alias cat="bat --style=auto" 2>/dev/null || alias cat="cat"
alias grep="rg" 2>/dev/null || alias grep="grep --color=auto"
alias find="fd" 2>/dev/null || alias find="find"

# Git aliases
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git pull"
alias gd="git diff"
alias gco="git checkout"
alias glog="git log --oneline --graph --decorate"

# Quick directory navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias -- -="cd -"

# System
alias reload="source ~/.zshrc"
alias zshconfig="$EDITOR ~/.zshrc"
alias starconfig="$EDITOR ~/.config/starship.toml"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="$HOME/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
