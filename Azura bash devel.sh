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
        echo -e " azura remove : remove the package "
        echo -e " azura info : show the information about the package "
	echo -e "azura sync : a page with some informations about packages available"
	echo -e "If you want to have more information about this pm, please execute 'azura about' or read the documentation (not available for the moment)
}


# Add a package from the NCR
function compile () {
        echo -e "Nous vérifions que le répertoire de build de azura est propre"
        cd /var/cache/azura
        if [[$? = 1]]
              mkdir /var/cache/azura
        rm -rf /var/cache/azura/*
        # Nous allons copier votre pkgfile dans notre fichier de build
        cp $fichier /var/cache/azura
        # Nous procédons à la compilation de votre paquet
        pkgmk -d $name
        pkgadd $name
        if [[$? = 1]]
	      cards install cards.devel
        fi
        pkgmk -d $name
        pkgadd $name
}
# Remove a package
function remove () {
        echo -e "Wait few second"
        read -r -p "Are you sure to want to continue ? O/N" reponse
        case ${reponse} in
       [oO][uU][iI]|[oO])
              echo -e " Please wait few second "
              cards remove $name
              exit
              ;;
        [nN][oO][nN]|[nN])
               echo -e "Annulation"
               exit
               ;;
         *)
               echo "Sorry we didn't understand your answer, please launch the command again"
               exit
                ;;

# ferme le case
         esac
}

# Show information about the package
function info () {
        echo -e " Please try to read the Azura database, execute this command ...... "
}
# Search a package in the NCR
function search () {


}

# Function main
function main () {
# Si l'user tape compile, lance la commande compile
        if [ "$OPT_MODE" = "compile $fichier $name" ]; then
			compile
# Si rien n'est tapé afficher l'aide
	if [[ $# = 0 ]];then
		help
	fi

# Si l'user tape help, affiche l'aide
        if [ "$OPT_MODE" = "help" ]; then
	        help
        fi

# Data sync

	if [ "$OPT_MODE" = "sync" ]; then
		database-sync
	fi

}
# Le main @$ après la fermeture de la fonction sinon elle ne s'arrete pas
main @$

# End of Azura code.
# Thanks to all the contributors
