# sqlkiller
Supprime toutes les requêtes SELECT trop longue (supérieur à 150s)
# 
Modifier le nom des variables dans le fichier sqlquerykiller.sh
\
Copier celui-ci dans un dossier PATH (par exemple /etc/sqlquerykiller.sh)
\
Le rendre executable (chmod +x /etc/sqlquerykiller.sh)
\
\
Copier le fichier requestkillerSQL.service dans le dossier /etc/systemd/system/
\
Activer le service par la commande : systemctl enable requestkillerSQL.service
\
Démarrer le service via systemctl start requestkillerSQL
\
***/!\ Si vous modifié le dossier dans lequel se trouve le script sqlquerykiller.sh attention à bien le modifier dans le fichier .service***
