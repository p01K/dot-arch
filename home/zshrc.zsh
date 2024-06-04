# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory autocd extendedglob notify
unsetopt complete_aliases
unsetopt completealiases

#bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/p01/.zshrc'
plugins+=(zsh-completions)
autoload -U colors && colors
autoload -Uz compinit

[[ -d ~/.zfunc ]] && fpath+=~/.zfunc

compinit
# End of lines added by compinstall
#

##########################
#     KEYBINDINGS
bindkey ';5D' backward-word #Control <-
bindkey ';5C' forward-word  #Control ->
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^R' history-incremental-search-backward
bindkey '^P' history-beginning-search-backward
bindkey '^K' kill-line
bindkey '^L' clear-screen
bindkey '^[d' kill-word
#########################



########### tests #########
zstyle ':completion:*' menu select
setopt HIST_IGNORE_DUPS
setopt APPEND_HISTORY # adds history
setopt INC_APPEND_HISTORY SHARE_HISTORY
###################

##################### exports ###########################
export XAUTHORITY=/home/$USER/.Xauthority
export EDITOR='micro'
export MAIL="$HOME/docs/mail"
#################### /exports ##########################


###################### generic ##########################
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -a'
alias ls.rec='ls -R -l'
alias grep='grep --colour -n'
alias open='xdg-open'
alias i3lock='i3lock --color 000000'
alias xrandr.off='xrandr --output DP1 --off --output DP2 --off --output VGA1 --off --output HDMI1 --off'
alias xrandr.lvds0='xrandr --output LVDS1 --off'
alias xrandr.dp2='xrandr --output DP2 --auto --output LVDS1 --off'
alias xrandr.dp1='xrandr --output DP1 --auto --output LVDS1 --off'
alias xrandr.vga1='xrandr --output VGA1 --auto --output LVDS1 --off'


alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
##################### /generic ##########################

########### PACMAN SHORTCUTS ######################
##Taken from https://wiki.archlinux.org/index.php/Pacman/Tips_and_tricks
function pac_remove_orphan {
 sudo pacman -Rns $(pacman -Qtdq)
}

function pac_dependencies {
 pacman -Si $1 | awk -F'[:<=>]' '/^Depends/ {print $2}' | xargs -n1 | sort -u
}
alias pac.sy='sudo pacman -Sy'
alias pac.s='sudo pacman -S'
alias pac.ss='pacman -Ss'
alias pac.syyu='sudo pacman -Syyu' #full system  upgrade
alias pac.r='sudo pacman -R'
alias pac.rsn='sudo pacman -Rsn'  #also remove unused
alias pac.rdd='sudo pacman -Rdd' #force removal
alias pac.si='pacman -Si'   #display extensive info
alias pac.qdt='sudo pacman -Qdt' #orphan packages
alias pac.scc='sudo pacman -Scc' #clean pacman caches
alias pac.ql='pacman -Ql'
alias pac.qo='pacman -Qo' #query the owner(package) of the file
alias pac.tree='pactree'
############ /PACMAN SHORTCUTS #####################

########### networking ################################
alias dmesg='dmesg -L' #add colours to the dmesg output
alias ss.tcp_l='ss -rplt'

man(){
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}

enable_alt_shift(){
	setxkbmap -layout us,gr -option grp:alt_shift_toggle
}


function set_space_prompt {
    PROMPT=' '
}

function set_full_prompt {
  PROMPT="%{$fg[yellow]%}%n%{$reset_color%} %{$fg[yellow]%}%~ $\$ %{$reset_color%}"
 }


tar.extract() {
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
	*.tar.xz)    tar xf  $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

[ -n "$DISPLAY" ] && [[ "$XDG_SESSION_TYPE" != "wayland" ]] && setxkbmap -option 'ctrl:nocaps' #disable caps lock

set_space_prompt

if [[ -f "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] ; then
   source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
   echo "Install syntax highlighting"
fi
[ -n "$DISPLAY" ] && xset b off #disable bell sound in xterm


#go things
if [[ -d ~/.go ]]; then
    export GOPATH=~/.go
    [[ ! -d $GOPATH/bin ]] && mkdir $GOPATH/bin
    export GOBIN=$GOPATH/bin
    export PATH=$PATH:~/.go/bin
fi
export GTK2_RC_FILES=/usr/share/themes/Orion/gtk-2.0/gtkrc

[[ -d ~/.local/bin ]] && [[ :$PATH: != *:/home/p01/.local/bin:* ]] && export PATH=$PATH:~/.local/bin
[[ -d ~/bin ]] && [[ :$PATH: != *:/home/p01/bin:* ]] && export PATH=$PATH:~/bin
