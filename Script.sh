#Bash 

OPT_MODE=$1
function install () {
       get firefox cards.devel git gimp flameshot flcards telegram-desktop discord
}

function main () {
       if [[ "$OPT_MODE" = "-d" ]];then
               install 
       fi
} 
main "@$" 
            
          
