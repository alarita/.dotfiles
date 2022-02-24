# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

# Change cursor to I-beam
printf '\033[5 q\r'

# Move prompt to the bottom
printf '\n%.0s' {1..100}

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/alarita/.oh-my-zsh"

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

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
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
plugins=(git)

source $ZSH/oh-my-zsh.sh

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

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
source ~/powerlevel10k/powerlevel10k.zsh-theme
. ~/.aliases

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

alias gs='git status'
alias gaa='git add .'
alias gc='git commit'
alias gcm='git commit -m'
alias gco='git checkout'
alias gb='git branch'
alias gbd='git branch -d'
alias glg='git lg'
alias gpot='git push origin --tags'
alias gpom="git push origin master"
alias gpomn="git push origin main"
alias gpu="git fetch && git checkout master && git pull"
alias gpod="git push origin develop"
alias gpos="git push origin staging"
alias gp="git pull"
alias gpub='gaa && gc && gpom'
alias gpus='gaa && gc && gpos'
alias gcp='git cherry-pick'
alias codes='cd ~/Codes'
alias spinetixproj='cd ~/Codes/spinetix'
alias malupetsproj='cd ~/Codes/malupets'

create_branch () {
  branch=$1
  branch=${branch// /\-}
  base_branch=$2


  git checkout $base_branch
  git fetch
  git pull

  echo Creating Branch $branch
  git checkout -b $branch

  echo 'Publish to upstream? (y/n)'
  read upstream

  if [[ $upstream == 'y' ]]
  then
     git push -u origin $branch
  fi
}

open_spx_cloud_core () {
  nvm use 14
  sudo ntpdate -s time.windows.com
  cd ~/Codes/spinetix/cloud-core
  git fetch
  aws sso login --profile spx-assh
  npm run co:login
  npm ci
}

open_spx_init() {
  export AWS_PROFILE=spinetix
  export AWS_REGION=eu-central-1
  nvm use 14
  gh auth login
  git fetch
  yarn --ignore-engines

  echo 'Initialized CDK? (y/n)'
  read withCdk

  if [[ $withCdk == 'y' ]]
  then
	  cd cdk

	  aws sso login --profile spx-assh
	  npm run co:login
	  npm ci
	  yawsso -p spx-assh
	  ..
  fi
}

open_spx_cloud_backend () {
  cd ~/Codes/spinetix/cloud-backend
  open_spx_init
}

open_spx_cloud_iot () {
  cd ~/Codes/spinetix/cloud-iot-enrollment
  open_spx_init
}

create_release () {
  echo 'Continue to create release and publish' $1'? (y/n) '
  read response

  if [[ $response == 'y' ]]
  then
    git flow release start $1
    git flow release publish $1
  fi
}

undo_commit () {
  git log --name-status HEAD^..HEAD
  echo 'Undo last commit? (y/n)'
  read response

  if [[ $response == 'y' ]]
  then
	 git reset --soft HEAD~1
	 git restore --staged .
  fi
}

export PATH=~/.local/bin:$PATH
export PATH=$PATH:/usr/local/go/bin
