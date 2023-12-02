*******DO File comniné pour estimation******

*use "C:\Users\hp\Downloads\Base_education(EHCVM-19).dta"
/*
ssc install twowayfeweights
ssc install psmatch2
*/
clear
cls

global wd = "C:\Users\" + c(username) + "\OneDrive - GOUVCI\CAE_INS - Fichiers de Cellule d'Analyses Economiques ( CAE)\TRAVAUX DE RECHERCHES\En_Cours\Conflits_Education"

use "$wd\temp\base_education_estimation.dta", clear

******Identification et construction des cohortes (young cohorte and old cohorte)****

cap gen cohorte=0
replace cohorte=2 if inrange(age,12,22) 
replace cohorte=1 if inrange(age,23,33)
*Note: cohorte 1 est "la old cohorte" cohorte 2 " l jeune cohorte exposée au conflit de 2012*

***Traitement au conflit****

**Suppression des individus en dehors des cohortes d'intérêt

keep if inlist(cohorte,1,2)
cap gen trait=0
replace trait=1 if cohorte==2

**Traitement continu
cap gen Dcontinu=trait*total_conflit
**Traitement binaire (Spécification selon le nombre de conflits)**
cap gen D0 = 1*(total_conflit != 0)
cap gen D1=1
replace D1=0 if inlist(total_conflit,0,1)
cap gen D2=1
replace D2=0 if inlist(total_conflit,0,1,2)
cap gen D3=1
replace D3=0 if inlist(total_conflit,0,1,2,3)
cap gen D4=1
replace D4=0 if inlist(total_conflit,0,1,2,3,4)
***(alternatives: selon le type de conflits)***

**Estimation de l'effet***

/* Analyse descriptive */
mean nombre_educ, over(D0 trait)
mat list r(table)
mat define diff_diff_straight = J(6,3,0)
/* ajout des coefficients de la vielle cohorte trait=0*/
mat diff_diff_straight[1,1] = r(table)[1,1]
mat diff_diff_straight[1,2] = r(table)[1,3]
/* ajout des erreurs standards */
mat diff_diff_straight[2,1] = r(table)[2,1]
mat diff_diff_straight[2,2] = r(table)[2,3]

/* ajout des coefficients de la jeune cohorte trait=1*/
mat diff_diff_straight[3,1] = r(table)[1,2]
mat diff_diff_straight[3,2] = r(table)[1,4]
/* ajout des erreurs standards */
mat diff_diff_straight[4,1] = r(table)[2,2]
mat diff_diff_straight[4,2] = r(table)[2,4]

/* ajout des differences war vs nowar de la vielle cohorte trait=0*/
ttest nombre_educ if trait==0, by(D0)
mat diff_diff_straight[1,3] = diff_diff_straight[1,1] - diff_diff_straight[1,2]
mat diff_diff_straight[2,3] = r(se)

/* ajout des differences war vs nowar de la jeune cohorte trait=1*/
ttest nombre_educ if trait==1, by(D0)
mat diff_diff_straight[3,3] = diff_diff_straight[3,1] - diff_diff_straight[3,2]
mat diff_diff_straight[4,3] = r(se)

/* ajout des differences vielle vs jeune cohorte en non zone de guerre*/
ttest nombre_educ if D0==0, by(trait)
mat diff_diff_straight[5,1] = diff_diff_straight[1,1] - diff_diff_straight[3,1]
mat diff_diff_straight[6,1] = r(se)

/* ajout des differences war vs nowar de la jeune cohorte trait=1*/
ttest nombre_educ if D0==1, by(trait)
mat diff_diff_straight[5,2] = diff_diff_straight[1,2] - diff_diff_straight[3,2]
mat diff_diff_straight[6,2] = r(se)

/* ajout des diff in diff*/
reg nombre_educ i.D0##i.trait
mat diff_diff_straight[5,3] = r(table)[1,8]
mat diff_diff_straight[6,3] = r(table)[2,8]

mat rownames diff_diff_straight  = "Cohorte 23 - 33" "se" "Cohorte 12 - 22" "se" "Difference" "se"

mat colnames diff_diff_straight  = "Absence Conflit" "Conflit" "Difference" 

/*Tableau diff in diff brut */
mat list diff_diff_straight

/*Approche par regression MCO*/
*cas binaire
reg nombre_educ depart2 age i.D0##i.trait
reg nombre_educ depart2 age i.D0##i.trait i.sexe
reg nombre_educ depart2 age i.D0##i.trait i.sexe i.milieu
reg nombre_educ depart2 age i.D0##i.trait i.sexe i.milieu i.religion 

*cas continu
reg nombre_educ depart2 age c.total_conflit##i.trait
reg nombre_educ depart2 age c.total_conflit##i.trait i.sexe
reg nombre_educ depart2 age c.total_conflit##i.trait i.sexe i.milieu
reg nombre_educ depart2 age c.total_conflit##i.trait i.sexe i.milieu i.religion 

/*Approche en diff in diff classique*/

*cas binaire sans contrôles
gen D0_did = D0*trait
gen D1_did = D1*trait
didregress (nombre_éducation) (Dcontinu,continuous),group(depart2) time(cohorte)
didregress (nombre_éducation) (D1_did),group(depart2) time(cohorte)
didregress (nombre_éducation) (D2),group(depart2) time(age)
didregress (nombre_éducation) (D3),group(depart2) time(age)
didregress (nombre_éducation) (D4),group(depart2) time(age)

*cas binaire avec contrôles
didregress (nombre_éducation i.sexe) (D0_did),group(depart2) time(age)
didregress (nombre_éducation i.sexe i.milieu) (D0_did),group(depart2) time(age)
didregress (nombre_éducation i.sexe i.milieu i.religion) (D0_did),group(depart2) time(age)


*cas continu sans contrôles
didregress (nombre_éducation) (Dcontinu, continuous),group(depart2) time(age)

*cas continu sans contrôles
didregress (nombre_éducation i.sexe) (Dcontinu, continuous),group(depart2) time(age)
didregress (nombre_éducation i.sexe i.milieu) (Dcontinu, continuous),group(depart2) time(age)
didregress (nombre_éducation i.sexe i.milieu i.religion) (Dcontinu, continuous),group(depart2) time(age)

/* Estimation avec Chaisemartin & Hautfoeille (2019) */

replace religion = 3 if inlist(religion,4,5)
foreach var in sexe milieu religion {
	ta `var', gen(`var'_bin)
}

twowayfeweights nombre_éducation depart2 age Dcontinu, type(feTR) summary_measures
global bin_control = "milieu_bin2 sexe_bin2"



/* Traitement continu */
did_multiplegt_dyn nombre_educ depart2 cohorte Dcontinu
graph export "$wd\img\chaisemartin_hautfoeille_Dcontinu_sans_controle.png", replace
/* Traitement continu */
did_multiplegt_dyn nombre_educ depart2 cohorte D0_did
graph export "$wd\img\chaisemartin_hautfoeille_Dbinaire_sans_controle.png", replace
did_multiplegt_dyn nombre_educ depart2 cohorte D0_did, controls(sexe_bin2)
graph export "$wd\img\chaisemartin_hautfoeille_Dbinaire_sans_controle.png", replace

**# Bookmark #1
did_multiplegt_dyn nombre_educ depart2 cohorte D0_did, controls($bin_control)
graph export "$wd\img\chaisemartin_hautfoeille_Dcontinu_avec_controle.png", replace


/*Approche par regression PSM*/

global var = "i.sexe i.religion i.milieu taille_menage"

**# Important #
/* Augmenter le nombre de variable explicatives, revoir Dabalen et al. 2012 pour avoir des idées */

psmatch2 D0_did $var , kernel k(biweight) out(nombre_éducation) ate
pstest, both graph  // graph utile
graph export "$wd\img\adjust1.png", replace
pstest, both scatter  // graph utile
graph export "$wd\img\adjust2_scatter.png", replace

teffects psmatch (nombre_éducation) (D0_did $var), atet
teffects psmatch (nombre_éducation) (D0_did $var), ate
tebalance density // graph à présenter dans le papier
graph export "$wd\img\adjust2_density.png", replace

teffects ipw (nombre_éducation) (D1 $var), ate //alternatives : Inverse Probability Weighting 
teffects ipwra (nombre_éducation $var) (D1 i.sexe $var), ate //alternatives :  Inverse Probability Weighted Regression Adjustment 
teffects aipw (nombre_éducation $var) (D1 $var), ate //alternatives :  Augmented Inverse Probability Weighting



/*Double Robust Estimation*/

