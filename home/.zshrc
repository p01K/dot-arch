# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory autocd extendedglob notify
setopt completealiases

#bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/p01/.zshrc'
plugins+=(zsh-completions)
autoload -U colors && colors
autoload -Uz compinit

compinit
# End of lines added by compinstall
#

##########################
#     KEYBINDINGS
bindkey ';5D' backward-word #Control <-
bindkey ';5C' forward-word  #Control ->

#########################



########### tests #########
zstyle ':completion:*' menu select
setopt HIST_IGNORE_DUPS
setopt APPEND_HISTORY # adds history
setopt INC_APPEND_HISTORY SHARE_HISTORY
setopt complete_aliases
###################

##################### exports ###########################
export ETH='enp0s25'
export WLAN='wlp3s0'
export VPN='ppp0'
export XAUTHORITY=/home/$USER/.Xauthority
export EDITOR='emacs'
export MAIL="$HOME/docs/mail"
#################### /exports ##########################


###################### generic ##########################
alias -g ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -a'
alias ls.rec='ls -R -l'
alias grep='grep --colour -n'
alias open='xdg-open'
alias i3lock='i3lock --color 000000'
alias rg='ranger'
alias xrandr.off='xrandr --output DP1 --off --output DP2 --off --output VGA1 --off --output HDMI1 --off'
alias xrandr.lvds0='xrandr --output LVDS1 --off'
alias xrandr.dp2='xrandr --output DP2 --auto --output LVDS1 --off'
alias xrandr.vga1='xrandr --output VGA1 --auto --output LVDS1 --off'


alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
##################### /generic ##########################

########### PACMAN SHORTCUTS ######################
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
alias pon='sudo pon'  #maybe with nodetach
alias poff='sudo poff'
alias iw.conn="sudo iw dev $WLAN connect"
alias iw.scan="sudo iw dev $WLAN scan"
alias ip.wup="sudo ip link set $WLAN up"

function wpa.supplicant
{
    sudo wpa_supplicant -i $WLAN -c /etc/wpa_supplicant/"$1".conf
}

########## /networking #################################
kate.noerr(){
    kate "$@" 2> /dev/null &
}

ssh.shark(){
    ssh shark -t ssh $1
}

pon.forth(){
    sudo pon forth nodetach
    sleep 3
    sudo ip route add 139.91.0.0/16 dev $VPN #change routing tab
}

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

setPROMPT(){
    local username='%n'
    local hostname='%M'
    local dir='%d'
    local time24='%*'
    local integral=$'\u222B'
    local reset="%{$reset_color%}"
    local newline="%{\n%}"
    PROMPT=' '
    [ -n "${KDE_FULL_SESSION}" ] && PROMPT="%{$fg_bold[white]$integral%}$reset%{$fg[cyan] ${time24}%}~%{$fg[white]${dir}%}~%{$fg[cyan]\$\$%}$reset"$'\n\t\t\t   \$\$' 
    RPROMPT=''
}

tar.extract() {
    if [ -f $1 ] ; then 
      case $1 in 
        *.tar.bz2)   tar xjf $1     ;; 
        *.tar.gz)    tar xzf $1     ;; 
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

[ -n "$DISPLAY" ] && setxkbmap -option 'ctrl:nocaps' #disable caps lock


[ -n "${KDE_FULL_SESSION}" ] && PATH="$PATH:`ruby -e 'print Gem.user_dir'`/bin"

setPROMPT

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -n "$DISPLAY" ] && xset b off #disable bell sound in xterm

#export t_Co=256
#[ -n "${KDE_FULL_SESSION}" ] &&  export TERM="xterm-256color"

if [[ "x$TERM" == "xxterm" ]] ; then
    export TERM=xterm-256color
fi
export JAVA_HOME="/usr/lib/jvm/java-7-openjdk"

# [[ -z "$TMUX" ]] && export TERM="screen-256color"
[[ -n "$TMUX" ]] && [[ -d ~/.oh-my-zsh ]] && export export ZSH=$HOME/.oh-my-zsh
[[ -n "$TMUX" ]] && ZSH_THEME="robbyrussell"
[[ -n "$TMUX" ]] && plugins=(git)
[[ -n "$TMUX" ]] && export PATH=$HOME/bin:/usr/local/bin:$PATH
[[ -n "$TMUX" ]] && [[ -d ~/.oh-my-zsh ]] && source $ZSH/oh-my-zsh.sh
# globalias() {
#    if [[ $LBUFFER =~ ' [A-Z0-9]+$' ]]; then
#      zle _expand_alias
#      zle expand-word
#    fi
#    zle self-insert
# }

# zle -N globalias



# bindkey " " globalias
# bindkey "^ " magic-space           # control-space to bypass completion
# bindkey -M isearch " " magic-space # normal space during searches

#if [[ -z "$TMUX" ]]; then 
#exec tmux
#else 
#    [ -n "${KDE_FULL_SESSION}" ] &&  archey3
#fi
