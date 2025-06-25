[[ $- != *i* ]] && return
export CLICOLOR=1
set enable-bracketed-paste on
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias la='ls -Alh'                
alias ls='ls -aFh --color=always' 
alias lx='ls -lXBh'               
alias lk='ls -lSrh'               
alias lc='ls -ltcrh'              
alias lu='ls -lturh'              
alias lr='ls -lRh'                
alias lt='ls -ltrh'               
alias lm='ls -alh |more'          
alias lw='ls -xAh'                
alias ll='ls -Fls'                
alias labc='ls -lap'              
alias lff="ls -l | egrep -v '^d'"  
alias ldir="ls -l | egrep '^d'"   
alias lla='ls -Al'                
alias las='ls -A'                 
alias lls='ls -l'                 
alias cal='cal -3'
alias alpine='qemu-system-x86_64 -enable-kvm -drive file=alpine -m 2048 -cpu host -display gtk'
alias debian='qemu-system-x86_64 -enable-kvm -m 2048 -cpu host -drive file=~/Desktop/virtual/disks/debian.qcow2 -boot d -net nic -net user -display gtk'
alias weather='curl -s "wttr.in?format=%l:+%C+%t,+%w+%m&T"; echo'
alias grep='grep --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias ss="scrot -s -d 2 -q 100 '%Y-%m-%d_%H-%M-%S.png' && mv *.png ~/Pictures/screenshots/ && notify-send 'Screenshot saved' "
PS1='\[\e[32m\]\w\[\e[0m\] \$ '
alias h="history | grep "
export EDITOR=vim
export VISUAL=vimbind
set completion-ignore-case on
shopt -s autocd
shopt -s cdspell
set -o vi
if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
			. /etc/bash_completion
			fi
			shopt -s histappend
			PROMPT_COMMAND='history -a'
			export HISTFILESIZE=10000
			export HISTSIZE=500
			export HISTTIMEFORMAT="%F %T"
			export HISTCONTROL=erasedups:ignoredups:ignorespace
			[[ $- == *i* ]] && stty -ixon
			if [[ $iatest -gt 0 ]]; then bind "set show-all-if-ambiguous On"; fi

			if [[ $iatest -gt 0 ]]; then bind "set completion-ignore-case on"; fi
export PATH="$HOME/.local/bin:$PATH"

