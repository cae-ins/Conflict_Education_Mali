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

* . sum nombre_éducation

    Variable |        Obs        Mean    Std. Dev.       Min        Max
-------------+---------------------------------------------------------
nombre_édu~n |      6,502    7.692864    4.221954          1         22


* pour déterminer le nombre d'années d'éducation, on croise la var s02q29 s0q31 ou s02q29 EST le niveau max atteint par l'individu et s02q31 la classe dans laquelle il se trouve;

/*
maternelle= 0ans
maternelle dure 3 ans max

pr
fondamental1= 3ANS

fondamental 1 dure 6 ans

Fin fondamental 1= 9ans


fin fondamental2:12 ans


secondaire général: 12 ans+ */


*taux de décrochage*

/*En pratique, elle correspond au fait qu'un élève se retrouve hors du système de formation sans que ce dernier n'ait obtenu son diplôme. Cette sortie du système peut être temporaire ou définitif. On parlera dès lors d'abandon scolaire lorsque cette sortie du système est définitive.*/

gen age_school=1 if inrange(s01q04a,3,18)

gen décrochage=0 if age_school==1
replace décrochage=1 if inrange(nombre_éducation,0,5) & s02q31==2
replace décrochage=1 if inrange(nombre_éducation,7,8) & s02q31==2 
replace décrochage=1 if inrange(nombre_éducation,10,11) & s02q31==2
replace décrochage=1 if inrange(s02q33,0,3) & nombre_éducation==12
tab décrochage

* le taux de décrochage pour la classe considérée est de 50,27%

/*
 tab NAME_2 year if inrange(year,2012,2019)

               |                                          year
        NAME_2 |      2012       2013       2014       2015       2016       2017       2018       2019 |     Total
---------------+----------------------------------------------------------------------------------------+----------
      Abeïbara |         2         30          2          2         12         13         10          0 |        71 
       Ansongo |        24          4          7          6          4         63         86         65 |       259 
     Bafoulabé |         0          0          0          0          0          0          1          1 |         2 
        Bamako |        81         47         19         30         20         33         46         74 |       350 
       Banamba |         0          0          0          0          2          0          8          3 |        13 
    Bandiagara |         0          2          0          0          2          8         16        168 |       196 
       Bankass |         0          0          0          2          0          6         44        127 |       179 
      Barouéli |         0          0          0          0          0          2          0          1 |         3 
           Bla |         0          0          0          0          0          2          0          0 |         2 
      Bougouni |         2          0          0          0          0          0          1          3 |         6 
        Bourem |         9          1         18         15          2         30         30         25 |       130 
        Dioïla |         0          0          0          0          0          0          6          2 |         8 
          Diré |         2          0          0          2          0          2          1         12 |        19 
         Diéma |         0          2          0          0          2          0          2          4 |        10 
        Djenné |         0          0          0          2          8         41         65         18 |       134 
      Douentza |        10         17          2         12         41        102        167        211 |       562 
           Gao |       111        119         37         30         24         53         64         60 |       498 
       Goundam |         8          1         11         10         10         18         24         36 |       118 
Gourma-Rharous |         0          9          2         18         16         32         67         35 |       179 
       Kadiolo |         2          0          0          2          2          0          0          4 |        10 
       Kangaba |         0          0          0          0          0          0          4          3 |         7 
          Kati |        13          4          0          6          2          2          1          9 |        37 
         Kayes |         0          0          3          0          0          0          3         13 |        19 
         Kidal |        44        100         73         49         34         81         43         20 |       444 
          Kita |         0          0          0          2          0          0          2          3 |         7 
      Kolokani |         1          0          0          0          0          0          3          2 |         6 
    Kolondiéba |         0          0          0          6          0          0          2          0 |         8 
          Koro |         6          0          0          2          6         35        149        232 |       430 
     Koulikoro |         0          0          0          0          0          0          0         10 |        10 
      Koutiala |         1          0          0          2          0          2          2          1 |         8 
       Kéniéba |         0          2          0          0          0          0          4          0 |         6 
        Macina |         0          0          0          2          0         21         43         32 |        98 
         Mopti |         4         53          0         10         10         20         64         51 |       212 
        Ménaka |        14         16         14         29         15         86        160         98 |       432 
          Nara |         2          0          0          2          4         10          8         11 |        37 
      Niafunké |        22         10          1          2          4         19         25         12 |        95 
         Niono |         8         25          0         14         14         32         31         14 |       138 
         Nioro |         0          0          0          0          0          0          1          2 |         3 
           San |         0          0          0          0          2          4          8          6 |        20 
       Sikasso |         0          0          1          0          0          0          2          6 |         9 
         Ségou |         0          1          0          0          0          5         10          7 |        23 
      Tessalit |        22         46         51         20         27         64         40         10 |       280 
    Tin-Essako |         0          0          2          0          0          6          2          2 |        12 
    Tombouctou |        82         71         38         32         41         49         64         50 |       427 
      Tominian |         0          0          0          0          0          8          4          4 |        16 
      Ténenkou |         2          6          0         20         12         44         76         32 |       192 
     Yanfolila |         0          0          0          2          0          0          2          4 |         8 
       Yorosso |         0          0          0          0          0          2          1         12 |        15 
      Youwarou |         2          0          0          2          0          8         28          7 |        47 
      Yélimané |         0          0          0          4          0          2          0          4 |        10 
---------------+----------------------------------------------------------------------------------------+----------
         Total |       474        566        281        337        316        905      1,420      1,506 |     5,805 

/*