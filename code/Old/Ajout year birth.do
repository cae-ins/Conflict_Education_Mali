use "D:\Impact of War on education\Fichiers_Menage&Individus\Base_education(EHCVM-19).dta" 

tab s01q03a
gen year_birth=s01q03c
label variable year_birth " year of birth"
bro s00q24b s00q23b vague

* there are missing values in year of birth, so we  input using age, date of collecting data via vague (vague two correspond to 2019 and vague 1 is 2018 ), so we have:

replace year_birth=2019-s01q04a if year_birth==9999 & vague==2
replace year_birth=2018-s01q04a if year_birth==9999 & vague==1