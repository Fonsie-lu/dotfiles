#" sora6kq based
# .zshrc

# start i3
if [ "$(tty)" = "/dev/tty1" ]; then
	exec i3
fi
if [[ $UID -ge 1000 && -d $HOME/bin && -z $(echo $PATH | grep -o $HOME/bin) ]]
then
    export PATH="${PATH}:$HOME/bin"
fi
#source
source /usr/share/fzf/key-bindings.zsh

#prompt
eval "$(starship init zsh)"
bindkey -s "^H" 'cd^M'
bindkey -s "^F" 'ranger^M'

#aliases
alias sudo="doas"
alias pacman="doas pacman"
alias pacs="doas pacman -S"
alias pacss="doas pacman -Ss"
alias pacr="doas pacman -Rns"
alias pacc='sudo pacman -Rns $(pacman -Qtdq)'
alias parus="paru -S"
alias paruss="paru -Ss"
alias u="paru -Syyu"
alias paruc="paru -c"
alias parur="paru -R"

alias mnt="udisksctl mount -b /dev/sdb1"
alias umnt="udisksctl unmount -b /dev/sdb1"
alias mntu="udisksctl mount -b /dev/sdc1"
alias umntu="udisksctl unmount -b /dev/sdc1"
alias systemctl="doas systemctl"
alias bashrc="nvim ~/.bashrc"
alias zconf="nvim ~/.zshrc"
alias lconf="sudo nvim /etc/ly/config.ini"
alias updatepac="reflector --country Switzerland,France,Germany --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist"

alias iconf="nvim ~/.config/i3/config"
alias nconf="nvim ~/.config/nvim/init.vim"
alias pconf="nvim ~/.config/polybar/config.ini"
alias rconf="nvim ~/.config/ranger/rc.conf"
alias aconf="nvim ~/.config/alacritty/alacritty.yml"

alias cd..=" .."
alias cd...=" ..."
alias cd....=" ...."
alias ls="lsd"
alias cat='bat'
alias v='nvim'
alias r='ranger'
alias cdd="cd ~/Downloads/"
alias cdc="cd ~/.config/"
alias cdc="cd ~/.config/"
alias gp="git add --all && git commit -m update && git push"

# fet.sh
# export info='n user os sh wm up kern pkgs term n'

#path
export EDITOR="/usr/share/nvim"
export VISUAL="/usr/share/nvim"
export QT_QPA_PLATFORMTHEME="qt5ct"
export GTK_THEME="Layan-dark"
export XDG_DOCUMENTS_DIR="~/doc"
export XDG_DOWNLOAD_DIR="~/dl"
export XDG_VIDEOS_DIR="~/vid"
export XDG_PICTURES_DIR="~/pic"
export XDG_CONFIG_DIR="~/.config"

# Rebind Home Del 
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char

# Addons
export RANGER_DEVICONS_SEPARATOR=" " 

# history
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# Misc
CASE_SENSITIVE="false"

pfetch
