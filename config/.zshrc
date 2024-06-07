# start hyprland
if [ "$(tty)" = "/dev/tty1" ]; then
	exec Hyprland
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Load completions
autoload -Uz compinit && compinit
zinit cdreplay -q

#source
source /usr/share/fzf/key-bindings.zsh

#prompt
bindkey -s "^H" 'cd^M'
bindkey -s "^F" 'yazi^M'

#aliases
alias xi="sudo xbps-install"
alias xq="xbps-query -Rs"
alias xr="sudo xbps-remove"
alias xu="sudo xbps-install -Su"

alias mnt1="udisksctl mount -b /dev/sda1"
alias umnt1="udisksctl unmount -b /dev/sda1"
alias mnt2="udisksctl mount -b /dev/sdb1"
alias umnt2="udisksctl unmount -b /dev/sdb1"
alias mntp="gio mount mtp://Xiaomi_Mi_9T_da92a6ca/"
alias umntp="gio mount -u mtp://Xiaomi_Mi_9T_da92a6ca/"
alias listp="gio mount -li | grep activation_root"
alias zconf="nvim ~/.zshrc"
alias hconf="nvim ~/.config/hypr/hyprland.conf"
alias nconf="nvim ~/.config/nvim/init.vim"
# alias rconf="nvim ~/.config/ranger/rc.conf"
# alias aconf="nvim ~/.config/alacritty/alacritty.toml"
alias kconf="nvim ~/.config/kitty/kitty.conf"
alias wconf="nvim ~/.config/waybar/config.jsonc"
alias fconf="nvim ~/.config/fastfetch/config.jsonc"
alias yconf="nvim ~/.config/yazi/yazi.toml"
alias bm="bashmount"
alias fm="yazi"

alias cd..="cd .."
alias cd...="cd ../.."
alias cd....="cd ../../.."
alias ls="lsd"
alias cat='bat'
alias cdd="cd ~/dl/"
alias cdc="cd ~/.config/"
alias bt="bluetuith"
alias gp="git add --all && git commit -m update && git push"
alias emptytrash="rm -rf ~/.local/share/Trash/*"

# Env
export EDITOR="nvim"
export VISUAL="nvim"
export QT_QPA_PLATFORMTHEME="qt5ct"
# export RANGER_DEVICONS_SEPARATOR=" "

# Rebind Home Del 
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Shell integrations
eval "$(starship init zsh)"
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# Misc
CASE_SENSITIVE="false"

fastfetch
