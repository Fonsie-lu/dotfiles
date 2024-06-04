# start hyprland
if [ "$(tty)" = "/dev/tty1" ]; then
	exec hyprland
fi

#source
source /usr/share/fzf/key-bindings.zsh

#prompt
eval "$(starship init zsh)"
bindkey -s "^H" 'cd^M'
bindkey -s "^F" 'ranger^M'

#aliases
alias xi="sudo xbps-install"
alias xq="xbps-query -Rs"
alias xr="sudo xbps-remove"
alias xu="sudo xbps-install -Su"

alias mnt="udisksctl mount -b /dev/sda1"
alias umnt="udisksctl unmount -b /dev/sda1"
alias mntu="udisksctl mount -b /dev/sdb1"
alias umntu="udisksctl unmount -b /dev/sdb1"
alias zconf="nvim ~/.zshrc"
alias hconf="nvim ~/.config/hypr/hyprland.conf"
alias nconf="nvim ~/.config/nvim/init.vim"
alias rconf="nvim ~/.config/ranger/rc.conf"
alias aconf="nvim ~/.config/alacritty/alacritty.yml"
alias wconf="nvim ~/.config/waybar/config.jsonc"

alias cd..=" .."
alias cd...=" ..."
alias cd....=" ...."
alias ls="lsd"
alias cat='bat'
alias cdd="cd ~/dl/"
alias cdc="cd ~/.config/"
alias bt="bluetuith"
alias gp="git add --all && git commit -m update && git push"
alias rrec="cd ~/.rec/Recordurbate/recordurbate/"

# Env
export EDITOR="nvim"
export VISUAL="nvim"
export QT_QPA_PLATFORMTHEME="qt5ct"
export RANGER_DEVICONS_SEPARATOR=" "

# Rebind Home Del 
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char

# history
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# Misc
CASE_SENSITIVE="false"

fastfetch
