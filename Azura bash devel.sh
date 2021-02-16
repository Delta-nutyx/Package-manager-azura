#! /bin/bash
# Azura : A cards complement build for manage package from the NCR( Nutyx Community Repository ).
# It's devel by Delta an old member of NuTyX devel team
# Warning this code may be unstable
# The first release will be publish in Azura build community repo
# This is an testing repo

# Contents :
#1ère partie : function Help
#2ème partie : function sync
#3ème partie : function compile (création en cours de travaux, normalement plus d'erreurs au niveau de la recherche de cards.devel)


# Function help
function help () {
        echo -e " azura compile : compile a software from its pkgfile "
}


# Add a package from the NCR
function compile () {
        echo -e "Nous vérifions que le répertoire de build de azura est propre"
        cd /var/cache/azura
        if [[$? = 1]]
              mkdir /var/cache/azura
        rm -rf /var/cache/azura/*
        read -p "Comment s'appelle votre paquet" name
        echo $name
        read -p "Donnez-nous le nom de votre pkgfile" $fichier
        echo $fichier 
        # Nous allons copier votre pkgfile dans notre fichier de build
        cp $fichier /var/cache/azura
        mv $chemin PKGBUILD 
        # Nous procédons à la compilation de votre paquet
        pkgmk -d $name
        pkgadd $name
        if [[$? = 1]]
              cards install cards.devel      
        fi
        pkgmk -d $name
        pkgadd $name
}



# Function main
function main () {
# Si l'user tape compile, lance la commande compile
        if [[ "$OPT_MODE" = "compile $fichier $name" ]]; then
                        compile
        fi
# Si rien n'est tapé afficher l'aide
	if [[ $# = 0 ]];then
		help
	fi

# Si l'user tape help, affiche l'aide
        if [ "$OPT_MODE" = "help" ]; then
                        help 
        fi


}
# Le main @$ après la fermeture de la fonction sinon elle ne s'arrete pas
main "@$"

# End of Azura code.
# Thanks to all the contributors
