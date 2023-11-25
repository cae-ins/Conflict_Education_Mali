*******DO File comniné pour estimation******

*use "C:\Users\hp\Downloads\Base_education(EHCVM-19).dta"

ssc install twowayfeweights

global wd = "C:\Users\Dell\OneDrive - GOUVCI\CAE_INS - Fichiers de Cellule d'Analyses Economiques ( CAE)\TRAVAUX DE RECHERCHES\En_Cours\Conflits_Education"

use "$wd\Data\base_education_Impact.dta", clear

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

gen nombre_éducation=alpha+beta
sum nombre_éducation

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
label variable nombre_éducation "years of education"

******Identification et construction des cohortes (young cohorte and old cohorte)****

gen cohorte=0
replace cohorte=2 if inrange(age,12,22) 
replace cohorte=1 if inrange(age,23,33)
*Note: cohorte 1 est "la old cohorte" cohorte 2 " l jeune cohorte exposée au conflit de 2012*

***Traitement au conflit****

**Suppression des individus en dehors des cohortes d'intérêt

keep if inlist(cohorte,1,2)
gen trait=0
replace trait=1 if cohorte==2

**Traitement continu
gen Dcontinu=trait*total_conflit
**Traitement binaire (Spécification selon le nombre de conflits)**
gen D0 = 1*(total_conflit != 0)
gen D1=1
replace D1=0 if inlist(total_conflit,0,1)
gen D2=1
replace D2=0 if inlist(total_conflit,1,2)
gen D3=1
replace D3=0 if inlist(total_conflit,1,2,3)
gen D4=1
replace D4=0 if inlist(total_conflit,1,2,3,4)
***(alternatives: selon le type de conflits)***

**Estimation de l'impact***

*cas continu

didregress (nombre_éducation) (Dcontinu, continuous),group(depart2) time(cohorte)

/*                              (Std. err. adjusted for 52 clusters in depart2)
------------------------------------------------------------------------------
             |               Robust
nombre_édu~n | Coefficient  std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
ATET         |
    Dcontinu |  -.1429314   .0427425    -3.34   0.002    -.2287406   -.0571223
------------------------------------------------------------------------------
*/
didregress (nombre_éducation) (Dcontinu, continuous),group(depart2) time(age)

*Age permet de capter l'année de naissance en lieu et place de la cohortes

didregress (nombre_éducation) (Dcontinu, continuous), group(depart2) time(age) nogteffects
/* 
                              (Std. err. adjusted for 52 clusters in depart2)
------------------------------------------------------------------------------
             |               Robust
nombre_édu~n | Coefficient  std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
ATET         |
    Dcontinu |  -.3462193   .0277917   -12.46   0.000    -.4020135   -.2904252
------------------------------------------------------------------------------

*L'option nogteffects exclue l'effet du département et la variable temporelles utilisée
*/

****************En utilisant les variables de controles (Cas continu)********************

didregress (nombre_éducation i.sexe i.milieu i.religion i.lien_CM i.Niveducation_père ) (Dcontinu, continuous), group(depart2) time(age)
/* 
                                                        (Std. err. adjusted for 50 clusters in depart2)
---------------------------------------------------------------------------------------------------------
                                        |               Robust
                       nombre_éducation | Coefficient  std. err.      t    P>|t|     [95% conf. interval]
----------------------------------------+----------------------------------------------------------------
ATET                                    |
                               Dcontinu |  -.1650035   .0616609    -2.68   0.010    -.2889157   -.0410913
---------------------------------------------------------------------------------------------------------
*/
didregress (nombre_éducation i.sexe i.milieu i.religion i.lien_CM i.Niveducation_père i.Niveducation_mère) (Dcontinu, continuous), group(depart2) time(age) nogteffects
*Impact= (-0,18***)

*******************Estimation en utilisant le cas binaire**********************

*****
*****
didregress (nombre_éducation) (D2) if total_conflit!=0, group(depart2) time(age)

didregress (nombre_éducation i.sexe i.milieu i.religion i.Niveducation_père) (D2) if total_conflit!=0, group(depart2) time(age)

didregress (nombre_éducation i.sexe i.milieu i.religion i.Niveducation_père) (D2) , group(depart2) time(age)


***** (Nous retenons prioritairement ce modèle D2)

*****
didregress (nombre_éducation) (D3) if total_conflit!=0, group(depart2) time(age)

didregress (nombre_éducation i.sexe i.milieu i.religion i.Niveducation_père) (D3) if total_conflit!=0, group(depart2) time(age)

didregress (nombre_éducation i.sexe i.milieu i.religion i.Niveducation_père) (D3) , group(depart2) time(age)


*****
*****
didregress (nombre_éducation) (D4) if total_conflit!=0, group(depart2) time(age)

didregress (nombre_éducation i.sexe i.milieu i.religion i.Niveducation_père) (D4) if total_conflit!=0, group(depart2) time(age)

didregress (nombre_éducation i.sexe i.milieu i.religion i.Niveducation_père) (D4), group(depart2) time(age)


*****

/* Estimation avec Chaisemartin & Hautfoeille (2019) */

*****************************Estimation En Utilisant le PSM********************************

/* Il faudra améliorer la manière d'écrire cette partie */
psmatch2 D2 i.sexe i.milieu i.Niveducation_père i.Niveducation_mère, kernel k(biweight) out(nombre_éducation) ate
pstest, both graph  // graph utile
graph export "$wd\Img\adjust1.png"
pstest, both scatter  // graph utile
graph export "$wd\Img\adjust2_scatter.png"

teffects psmatch (nombre_éducation) (D2 i.sexe i.milieu i.Niveducation_père i.Niveducation_mère), atet
teffects psmatch (nombre_éducation) (D2 i.sexe i.milieu i.Niveducation_père i.Niveducation_mère), ate
tebalance density // graph à présenter dans le papier
graph export "$wd\Img\adjust2_density.png"

teffects ipw (nombre_éducation) (D2 i.sexe i.milieu i.Niveducation_père i.Niveducation_mère), ate //alternatives : Inverse Probability Weighting 
teffects ipwra (nombre_éducation i.sexe i.milieu i.Niveducation_père i.Niveducation_mère) (D2 i.sexe i.milieu i.Niveducation_père i.Niveducation_mère), ate //alternatives :  Inverse Probability Weighted Regression Adjustment 
teffects aipw (nombre_éducation i.sexe i.milieu i.Niveducation_père i.Niveducation_mère) (D2 i.sexe i.milieu i.Niveducation_père i.Niveducation_mère), ate //alternatives :  Augmented Inverse Probability Weighting


/**********************************PROCHAINES ETAPES**********************************/
*			ECRIRE LES SYNTAXES D'EXPORTATIONS DES RESULTATS D'ESTIMATIONS   		  *
/*************************************************************************************/

