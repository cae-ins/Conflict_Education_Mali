clear
cls

global wd = "C:\Users\" + c(username) + "\OneDrive - GOUVCI\CAE_INS - Fichiers de Cellule d'Analyses Economiques ( CAE)\TRAVAUX DE RECHERCHES\En_Cours\Conflits_Education"

/*use "$wd\data\base_education_Impact.dta", clear*/

use "$wd\data\base_impact_education_30_11_23.dta", clear
*use "C:\Users\hp\Downloads\Base_education(EHCVM-19).dta"

****Variables éducationnellles******

****do file pour déterminer le nombre d'années d'éducation**

gen alpha=0 
replace alpha=0 if s02q29==2 
replace alpha=6 if s02q29==3
replace alpha=9 if s02q29==5
replace alpha=9 if s02q29==6
replace alpha=12 if s02q29==8

gen beta=1 if s02q31==1
replace beta=2 if s02q31==2
replace beta=3 if s02q31==3
replace beta=4 if s02q31==4
replace beta=5 if s02q31==5
replace beta=6 if s02q31==6
replace beta=7 if s02q31==7
replace beta=8 if s02q31==8
replace beta=9 if s02q31==9
replace beta=10 if s02q31==10

gen nombre_educ=alpha+beta
sum nombre_educ

/* . sum nombre_éducation

    Variable |        Obs        Mean    Std. Dev.       Min        Max
-------------+---------------------------------------------------------
nombre_édu~n |      6,502    7.692864    4.221954          1         22

*/

* pour déterminer le nombre d'années d'éducation, on croise la var s02q29 s0q31 ou s02q29 EST le niveau max atteint par l'individu et s02q31 la classe dans laquelle il se trouve;

****Incidence des conflits par département (Source ACLED)
rename dep depart2
gen total_conflit=0
replace total_conflit=2 if depart2==11
replace total_conflit=3 if depart2==13
replace total_conflit=2 if depart2==14
replace total_conflit=3 if depart2==15
replace total_conflit=1 if depart2==16
replace total_conflit=3 if depart2==17
replace total_conflit=1 if depart2==21
replace total_conflit=2 if depart2==22
replace total_conflit=2 if depart2==23
replace total_conflit=2 if depart2==24
replace total_conflit=6 if depart2==25
replace total_conflit=2 if depart2==26
replace total_conflit=6 if depart2==27
replace total_conflit=1 if depart2==31
replace total_conflit=3 if depart2==33
replace total_conflit=2 if depart2==34
replace total_conflit=3 if depart2==35
replace total_conflit=3 if depart2==36
replace total_conflit=2 if depart2==37
replace total_conflit=3 if depart2==41
replace total_conflit=1 if depart2==42
replace total_conflit=1 if depart2==43
replace total_conflit=4 if depart2==44
replace total_conflit=7 if depart2==45
replace total_conflit=4 if depart2==46
replace total_conflit=3 if depart2==47
replace total_conflit=7 if depart2==51
replace total_conflit=5 if depart2==52
replace total_conflit=4 if depart2==53
replace total_conflit=5 if depart2==54
replace total_conflit=8 if depart2==55
replace total_conflit=6 if depart2==56
replace total_conflit=5 if depart2==58
replace total_conflit=8 if depart2==61
replace total_conflit=5 if depart2==62
replace total_conflit=7 if depart2==63
replace total_conflit=7 if depart2==64
replace total_conflit=7 if depart2==65
replace total_conflit=8 if depart2==71
replace total_conflit=8 if depart2==72
replace total_conflit=7 if depart2==73
replace total_conflit=8 if depart2==81
replace total_conflit=7 if depart2==82
replace total_conflit=8 if depart2==83
replace total_conflit=4 if depart2==84
replace total_conflit=8 if depart2==91
replace total_conflit=8 if depart2==111

***************************************

****Label des variables et valeurs manquantes****

rename s00q04 milieu
rename s02q03 ecole_formelle
rename s02q04 raison_pas_formelle
rename s02q05 formation_formelle
rename s02q06 type_informelle
rename s02q07 Age_début
rename s01q01 sexe
rename s01q04a age

*********
gen year_birth=s01q03c
label variable year_birth " year of birth"
bro s00q24b s00q23b vague

* there are missing values in year of birth, so we  input using age, date of collecting data via vague (vague two correspond to 2019 and vague 1 is 2018 ), so we have:

replace year_birth=2019-age if year_birth==9999 & vague==2
replace year_birth=2018-age if year_birth==9999 & vague==1
**********
**remplacer les valeurs manquantes de l'âge**
replace age=2019-year_birth if age==. & vague==2
replace age=2018-year_birth if age==. & vague==1

**

******************************
rename s01q07 situation_matri
rename s01q10 age_mariage
rename s01q14 religion
rename s01q15 nation
rename s01q25 Niveducation_père
rename s01q26 Branche_père
rename s01q27 Catégorie_père
rename s01q28 Secteur_père
rename s01q32 Niveducation_mère
rename s01q33 Branche_mère
rename s01q34 Catégorie_mère
rename s01q35 Secteur_mère
rename s01q16 ethnie
rename s02q08 frequent_16
rename s02q09 type_école
rename s02q10 result_16
rename s02q11 motif_abandon
rename s02q12 frequent_18
rename s02q13 raison_pas_école
rename s02q14 niveau_etude18
rename s02q15 filière
rename s02q16 classe
rename s02q17 satisfaction
rename s02q19 type_école18
rename s02q20 Frais_inscriptions
rename s02q21 Frais_cotisations
rename s02q22 Frais_fournitures 
rename s02q23 Frais_materiels 
rename s02q24 Frais_uniform
rename s02q25 Frais_cantin
rename s02q26 Frais_transport
*rename s02q27 Frais_ autres
rename s02q28 bourse
rename s02q29 niveau_max
rename s02q30 Filière
rename s02q31 Last_clas
rename s02q32 Dernière_année
rename s02q33 diplome
rename s01q02 lien_CM
label variable nombre_educ "Nombre d'années d'études"

bysort grappe menage : gen taille_menage = _N

save "$wd\temp\base_education_estimation.dta", replace
