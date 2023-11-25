*****************************************************************
* Etude: Conflits & Education *
*	Réalisation: Josias Sadia*
*	Date: Septembre 2023												*
*****************************************************************

global wd = "C:\Users\" + c(username) + "\OneDrive - GOUVCI\CAE_INS - Fichiers de Cellule d'Analyses Economiques ( CAE)\TRAVAUX DE RECHERCHES\En_Cours\Conflits_Education"

global data = "$wd\Données"

global Do = "$wd\Code"

global Temp = "$wd\Temp"


/*
Importation des données de conflit 
*/
clear
import delimited "$data\2000-01-01-2023-09-14-Mali.csv", delimiters(";")
save "$data\donnees_conflit_mali.dta", replace
/*

