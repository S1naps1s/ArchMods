source /etc/profile
#cmatrix
RED="\e[31m"
STOP="\e[0m"
printf "${RED}"
printf "==========================================================================\n"
figlet -w 500 -f standard "          BY THE WAY,"
figlet -w 500 -f standard "          I RUN ARCH"
printf "==========================================================================\n"
printf "${STOP}"
neofetch
fortune
alias ls="ls -l --color=always"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
