# ---------
# ALISEES
# ---------
alias sx=startx
alias ls='ls --color=auto' 
alias ll='ls -lh --group-directories-first'
alias la='ls -Alh --group-directories-first'
alias ..='cd ..'
alias ...='cd ../..'
alias vim=nvim
alias cp='cp -r -v'
alias rm='rm -r'
alias rmf='rm -rf'
alias ka='pkill -9'
alias grep='grep --color=auto'
alias hist=history
alias ppath='echo -e ${PATH//:/\\n}'
alias ip='ip --color'
# apps
alias open='xdg-open'
alias iv='nsxiv'
alias record='ffmpeg -framerate 60 -f x11grab -i $DISPLAY -f pulse -i default '
alias play='mpv'
alias sc='scrot -d 1 ~/pix/screenshots/%Y-%m-%d-%T-screenshot.png; notify-send "Screenshot" "Screenshot saved"'

# ---------
# EXPORTS
# ---------
export HOME=~
export EDITOR="nvim"
export TERMINAL="kitty"
export TERM="xterm-256color"
export BROWSER="firefox"
export FILEMANAGER="thunar"
export VIDEOEDITOR="kdenlive"
export EMACS="emacsclient -c -a 'emacs'"

# Path
export PATH="$PATH:$HOME/bin:$HOME/.local/bin"
export PATH="$PATH:$XDG_DATA_HOME/nvim/mason/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$XDG_CONFIG_HOME/emacs/bin"
export PATH="$PATH:$XDG_DATA_HOME/uv/tools"
export PATH="$PATH:$XDG_DATA_HOME/npm/global/bin"
export PATH="$PATH:$GOPATH/bin"

# XDG
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CURRENT_DESKTOP=qtile
export XDG_SESSION_DESKTOP=qtile
  
# GO Lang
export GOPATH=$XDG_DATA_HOME/go
export GOBIN="$GOPATH/bin"
export GOMODCACHE="$XDG_CACHE_HOME/go/mod"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GOPROXY=https://package-mirror.liara.ir/repository/go/
export GOSUMDB=off

# NPM
# export NPM_CONFIG_REGISTRY=https://mirror2.chabokan.net/npm/
export PIP_INDEX_URL=https://mirror.chabokan.net/repository/pypi-proxy/simple
export COMPOSER_MIRROR_URL=https://mirror.chabokan.net/repository/composer-proxy/
export NPM_CONFIG_PREFIX=$XDG_DATA_HOME/npm/global

# pip
export PIP_INDEX_URL=https://mirror2.chabokan.net/pypi/simple/

# composer
export COMPOSER_MIRROR_URL=https://mirror.chabokan.net/repository/composer-proxy/

export QT_QPA_PLATFORMTHEME=qt6ct
export MANPAGER="nvim +Man!"

# History
export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTCONTROL=ignoredups:ignorespace
export HISTCONTROL=ignoreboth:erasedups

# ------------------
# EXTERNAL COMMANDS
# ------------------
source <(fzf --bash) 
eval "$(zoxide init bash)"

# ------------
# BINDS
# -----------
set -o vi
bind '"jk":vi-movement-mode'
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'
bind '"\C-n": history-search-forward'
bind '"\C-p": history-search-backward'
bind 'C-l':clear-screen
bind -x '"\C-@":"tmuxer"'

# ------------
# PROMPT
# -----------
# colors
RED='\[\e[91m\]'
NORMAL='\[\e[0m\]'

# prompt
PS1="[\u${RED}@${NORMAL}\h \W]\$ "
