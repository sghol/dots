# ================
# Fish
# ================
set -U fish_greeting

# ================
# Alises
# ================
abbr --add sx startx
alias ls 'ls --color=auto'
alias ll 'ls -lh --group-directories-first'
alias la 'ls -Alh --group-directories-first'
abbr --add .. 'cd ..'
abbr --add ... 'cd ../..'
abbr --add vim nvim
abbr --add cp 'cp -r -v'
abbr --add rm 'rm -r'
abbr --add rmf 'rm -rf'
abbr --add ka 'pkill -9'
abbr --add grep 'grep --color=auto'
abbr --add hist history
abbr --add open 'xdg-open'
abbr --add im nsxiv
abbr --add play mpv

abbr --add ppath 'echo $PATH | tr " " "\n"'   # print each PATH entry on a new line
abbr --add ip 'ip --color'
abbr --add record 'ffmpeg -framerate 60 -f x11grab -i $DISPLAY -f pulse -i default'
abbr --add sc 'scrot -d 1 ~/pix/screenshots/%Y-%m-%d-%T-screenshot.png; notify-send "Screenshot" "Screenshot saved"'

# ================
# Enviroment Variables
# ================
# Apps
set -x TERM xterm-256color
set -x HOME ~
set -x EDITOR nvim
set -x TERMINAL kitty
set -x BROWSER firefox
set -x FILEMANAGER thunar

# XDG
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_CACHE_HOME $HOME/.cache
set -x XDG_DATA_HOME $HOME/.local/share
set -x XDG_CURRENT_DESKTOP qtile
set -x XDG_SESSION_DESKTOP qtile

# Go
set -x GOPATH $XDG_DATA_HOME/go
set -x GOBIN $GOPATH/bin
set -x GOMODCACHE $XDG_CACHE_HOME/go/mod
set -x CARGO_HOME $XDG_DATA_HOME/cargo
set -x GOPROXY https://package-mirror.liara.ir/repository/go/
set -x GOSUMDB off

# PATH
set -x PATH $PATH $HOME/bin $HOME/.local/bin
set -x PATH $PATH $XDG_DATA_HOME/nvim/mason/bin
set -x PATH $PATH $HOME/.cargo/bin
set -x PATH $PATH $XDG_CONFIG_HOME/emacs/bin
set -x PATH $PATH $XDG_DATA_HOME/uv/tools
set -x PATH $PATH $XDG_DATA_HOME/npm/global/bin
set -x PATH $PATH $GOPATH/bin

export QT_QPA_PLATFORMTHEME=qt6ct

# NPM
set -x NPM_CONFIG_PREFIX $XDG_DATA_HOME/npm/global

# Mirrors :: will uncommented when mollas close the internet.
# set -x NPM_CONFIG_REGISTRY https://mirror2.chabokan.net/npm/
# set -x PIP_INDEX_URL https://mirror2.chabokan.net/pypi/simple/
# set -x COMPOSER_MIRROR_URL https://mirror2.chabokan.net/composer/

# shell tools
zoxide init fish | source
