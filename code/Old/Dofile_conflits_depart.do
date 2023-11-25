import excel "F:\ConflitDateZone.xls", sheet("ConflitDZ") firstrow clear
rename NAME_2 Departement
gen conflit = fatalities!=.
gen attack= sub_event_=="Armed clash"
encode sub_event_, gen(Type_Event)
ta Type_Event, gen(Type_Event_Mod)
ta Type_Event, nol
gen ID_base =_n

foreach var in conflit attack Type_Event_Mod1 Type_Event_Mod2 Type_Event_Mod3 Type_Event_Mod4 Type_Event_Mod5 Type_Event_Mod6 Type_Event_Mod7 Type_Event_Mod8 Type_Event_Mod9 Type_Event_Mod10 Type_Event_Mod11 Type_Event_Mod12 Type_Event_Mod13 Type_Event_Mod14 Type_Event_Mod15 Type_Event_Mod16 Type_Event_Mod17 Type_Event_Mod18 Type_Event_Mod19 Type_Event_Mod20 Type_Event_Mod21 Type_Event_Mod22 Type_Event_Mod23 Type_Event_Mod24 {
	bysort year ID_1 ID_2 : egen `var'_Dep = total(`var')
}
drop if inlist(Type_Event,5,9,18,16,21,17,19,2)
* suppression des violences sexuelles, protestation pacifique, les arrestations (Pour plus d'infs, voir)

duplicates drop year ID_1 ID_2, force

xtset Dep year
tsfill, full
gen traite_confli=conflit!=.


foreach var in conflit attack Type_Event_Mod1 Type_Event_Mod2 Type_Event_Mod3 Type_Event_Mod4 Type_Event_Mod5 Type_Event_Mod6 Type_Event_Mod7 Type_Event_Mod8 Type_Event_Mod9 Type_Event_Mod10 Type_Event_Mod11 Type_Event_Mod12 Type_Event_Mod13 Type_Event_Mod14 Type_Event_Mod15 Type_Event_Mod16 Type_Event_Mod17 Type_Event_Mod18 Type_Event_Mod19 Type_Event_Mod20 Type_Event_Mod21 Type_Event_Mod22 Type_Event_Mod23 Type_Event_Mod24 {
	total `var'_Dep
}
