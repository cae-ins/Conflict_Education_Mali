cap drop region
gen int region = .
replace region = 1 if NAME_1 == "Kayes"
replace region = 2 if NAME_1 == "Koulikoro"
replace region = 3 if NAME_1 == "Sikasso"
replace region = 4 if NAME_1 == "Ségou"
replace region = 5 if NAME_1 == "Mopti"
replace region = 6 if NAME_1 == "Timbuktu"
replace region = 7 if NAME_1 == "Gao"
replace region = 8 if NAME_1 == "Kidal"
replace region = 9 if NAME_1 == "Bamako"

cap drop depart2
gen int depart2 = .
replace depart2 = 11 if Departement=="Kayes" & 
replace depart2 = 12 if Departement=="Bafoulabé" & 
replace depart2 = 13 if Departement=="Diéma" & 
replace depart2 = 14 if Departement=="Kéniéba" & 
replace depart2 = 15 if Departement=="Kita" & 
replace depart2 = 16 if Departement=="Nioro" & 
replace depart2 = 17 if Departement=="Yélimané" & 
replace depart2 = 21 if Departement=="Koulikoro"
replace depart2 = 22 if Departement=="Banamba"
replace depart2 = 23 if Departement=="Dioïla"
replace depart2 = 24 if Departement=="Kangaba"
replace depart2 = 25 if Departement=="Kati"
replace depart2 = 26 if Departement=="Kolokani"
replace depart2 = 27 if Departement=="Nara"
replace depart2 = 31 if Departement=="Sikasso"
replace depart2 = 32 if Departement=="Bougouni"
replace depart2 = 33 if Departement=="Kadiolo"
replace depart2 = 34 if Departement=="Kolondiéba"
replace depart2 = 35 if Departement=="Koutiala"
replace depart2 = 36 if Departement=="Yanfolila"
replace depart2 = 37 if Departement=="Yorosso"
replace depart2 = 41 if Departement=="Ségou"
replace depart2 = 42 if Departement=="Barouéli"
replace depart2 = 43 if Departement=="Bla"
replace depart2 = 45 if Departement=="Niono"
replace depart2 = 44 if Departement=="Macina"
replace depart2 = 46 if Departement=="San"
replace depart2 = 47 if Departement=="Tominian"
replace depart2 = 51 if Departement=="Mopti"
replace depart2 = 52 if Departement=="Bandiagara"
replace depart2 = 53 if Departement=="Bankass"
replace depart2 = 54 if Departement=="Djenné"
replace depart2 = 55 if Departement=="Douentza"
replace depart2 = 56 if Departement=="Koro"
replace depart2 = 58 if Departement=="Youwarou"
replace depart2 = 61 if Departement=="Tombouctou"
replace depart2 = 62 if Departement=="Diré"
replace depart2 = 63 if Departement=="Goundam"
replace depart2 = 64 if Departement=="Gourma-Rharous"
replace depart2 = 65 if Departement=="Niafunké"
replace depart2 = 71 if Departement=="Gao"
replace depart2 = 72 if Departement=="Ansongo"
replace depart2 = 73 if Departement=="Bourem"

/* Demander à DIALLO pour Menaka dans Gao et Menaka simple */
*replace depart2 = 74 if Departement=="Menaka"
replace depart2 = 111 if Departement=="Ménaka"
replace depart2 = 81 if Departement=="Kidal"
replace depart2 = 83 if Departement=="Tessalit"
replace depart2 = 91 if Departement=="Bamako" & NAME_1=="Bamako"
replace depart2 = 82 if Departement=="Abeïbara"
replace depart2 = 84 if Departement=="Tin-Essako"
/* A exécuter lorsqu'on aura un shapefile plus à jour 
replace depart2 = 102 if Departement=="ACHOURATT" & NAME_1=="Taoudénit"
replace depart2 = 103 if Departement=="ALOURCHE" & NAME_1=="Taoudénit"
replace depart2 = 104 if Departement=="ARAWANE" & NAME_1=="Taoudénit"
replace depart2 = 105 if Departement=="BOUZBEHA" & NAME_1=="Taoudénit"
replace depart2 = 106 if Departement=="FOUM ELBA" & NAME_1=="Taoudénit"
replace depart2 = 101 if Departement=="TAOUDENIT" & NAME_1=="Taoudénit"
*/

/* Le département de tenenkou présent dans les données de ACLED est absent de la liste de l'EHCVM 2018 */

/* Ainsi afin de réaliser la fusion, nous le supprimons de la base de données des conflits */

/* Tous les départements ayant des valeurs manquantes à conflit, n'ont pas connu de conflits */

foreach var in conflit conflit_Dep traite_confli {
	replace `var'=0 if `var'==.
}

foreach var in Type_Event_Mod1_Dep Type_Event_Mod2_Dep Type_Event_Mod3_Dep Type_Event_Mod4_Dep Type_Event_Mod5_Dep Type_Event_Mod6_Dep Type_Event_Mod7_Dep Type_Event_Mod8_Dep Type_Event_Mod9_Dep Type_Event_Mod10_Dep Type_Event_Mod11_Dep Type_Event_Mod12_Dep Type_Event_Mod13_Dep Type_Event_Mod14_Dep Type_Event_Mod15_Dep Type_Event_Mod16_Dep Type_Event_Mod17_Dep Type_Event_Mod18_Dep Type_Event_Mod19_Dep Type_Event_Mod20_Dep Type_Event_Mod21_Dep Type_Event_Mod22_Dep Type_Event_Mod23_Dep Type_Event_Mod24_Dep {
	replace `var'=0 if `var'==.
}

/* Le conflit se définit par traite_confli == 1 */

/* Indiquer les codes EHCVM des départements pour les années où le département n'a pas eu de conflit */

replace depart2 = 11 if Departement_xtset_encode=="Kayes":Departement_xtset_encode
replace depart2 = 12 if Departement_xtset_encode=="Bafoulabé":Departement_xtset_encode 
replace depart2 = 13 if Departement_xtset_encode=="Diéma":Departement_xtset_encode 
replace depart2 = 14 if Departement_xtset_encode=="Kéniéba":Departement_xtset_encode 
replace depart2 = 15 if Departement_xtset_encode=="Kita":Departement_xtset_encode 
replace depart2 = 16 if Departement_xtset_encode=="Nioro":Departement_xtset_encode
replace depart2 = 17 if Departement_xtset_encode=="Yélimané":Departement_xtset_encode 

replace depart2 = 21 if Departement_xtset_encode=="Koulikoro":Departement_xtset_encode
replace depart2 = 22 if Departement_xtset_encode=="Banamba":Departement_xtset_encode
replace depart2 = 23 if Departement_xtset_encode=="Dioïla":Departement_xtset_encode
replace depart2 = 24 if Departement_xtset_encode=="Kangaba":Departement_xtset_encode
replace depart2 = 25 if Departement_xtset_encode=="Kati":Departement_xtset_encode
replace depart2 = 26 if Departement_xtset_encode=="Kolokani":Departement_xtset_encode
replace depart2 = 27 if Departement_xtset_encode=="Nara":Departement_xtset_encode
replace depart2 = 31 if Departement_xtset_encode=="Sikasso":Departement_xtset_encode
replace depart2 = 32 if Departement_xtset_encode=="Bougouni":Departement_xtset_encode
replace depart2 = 33 if Departement_xtset_encode=="Kadiolo":Departement_xtset_encode
replace depart2 = 34 if Departement_xtset_encode=="Kolondiéba":Departement_xtset_encode
replace depart2 = 35 if Departement_xtset_encode=="Koutiala":Departement_xtset_encode
replace depart2 = 36 if Departement_xtset_encode=="Yanfolila":Departement_xtset_encode
replace depart2 = 37 if Departement_xtset_encode=="Yorosso":Departement_xtset_encode
replace depart2 = 41 if Departement_xtset_encode=="Ségou":Departement_xtset_encode
replace depart2 = 42 if Departement_xtset_encode=="Barouéli":Departement_xtset_encode
replace depart2 = 43 if Departement_xtset_encode=="Bla":Departement_xtset_encode
replace depart2 = 45 if Departement_xtset_encode=="Niono":Departement_xtset_encode
replace depart2 = 44 if Departement_xtset_encode=="Macina":Departement_xtset_encode
replace depart2 = 46 if Departement_xtset_encode=="San":Departement_xtset_encode
replace depart2 = 47 if Departement_xtset_encode=="Tominian":Departement_xtset_encode
replace depart2 = 51 if Departement_xtset_encode=="Mopti":Departement_xtset_encode
replace depart2 = 52 if Departement_xtset_encode=="Bandiagara":Departement_xtset_encode
replace depart2 = 53 if Departement_xtset_encode=="Bankass":Departement_xtset_encode
replace depart2 = 54 if Departement_xtset_encode=="Djenné":Departement_xtset_encode
replace depart2 = 55 if Departement_xtset_encode=="Douentza":Departement_xtset_encode
replace depart2 = 56 if Departement_xtset_encode=="Koro":Departement_xtset_encode
replace depart2 = 58 if Departement_xtset_encode=="Youwarou":Departement_xtset_encode
replace depart2 = 61 if Departement_xtset_encode=="Tombouctou":Departement_xtset_encode
replace depart2 = 62 if Departement_xtset_encode=="Diré":Departement_xtset_encode
replace depart2 = 63 if Departement_xtset_encode=="Goundam":Departement_xtset_encode
replace depart2 = 64 if Departement_xtset_encode=="Gourma-Rharous":Departement_xtset_encode
replace depart2 = 65 if Departement_xtset_encode=="Niafunké":Departement_xtset_encode
replace depart2 = 71 if Departement_xtset_encode=="Gao":Departement_xtset_encode
replace depart2 = 72 if Departement_xtset_encode=="Ansongo":Departement_xtset_encode
replace depart2 = 73 if Departement_xtset_encode=="Bourem":Departement_xtset_encode

/* Demander à DIALLO pour Menaka dans Gao et Menaka simple */
*replace depart2 = 74 if Departement=="Menaka"
replace depart2 = 111 if Departement_xtset_encode=="Ménaka":Departement_xtset_encode
replace depart2 = 81 if Departement_xtset_encode=="Kidal":Departement_xtset_encode
replace depart2 = 83 if Departement_xtset_encode=="Tessalit":Departement_xtset_encode
replace depart2 = 91 if Departement_xtset_encode=="Bamako":Departement_xtset_encode
replace depart2 = 82 if Departement_xtset_encode=="Abeïbara":Departement_xtset_encode
replace depart2 = 84 if Departement_xtset_encode=="Tin-Essako":Departement_xtset_encode



/* Fusion avec les données de l'EHCVM */

save base_conflits_codifie_sans_tenenkou.dta, replace

preserve
keep if inrange(year,2012,2019)==1
save base_conflits_codifie_sans_tenenkou_2012_2019.dta, replace
restore
