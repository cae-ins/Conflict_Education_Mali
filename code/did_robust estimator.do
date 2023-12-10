*****Estimation de double robust estimation****

logit a i.x*ybase

predict pihat
generate invwt=a/pihat + (1-a)/(1-pihat)

histogram pihat, by(a)
regress y a [pweight=invwt]
regress y ybase x intxy ysqr intxy2 if a==1
predict mu1
regress y ybase x intxy ysqr intxy2 if a==0
predict mu0

generate mdiff1=(-(a-pihat)*mu1/pihat)-((a-pihat)*mu0/(1-pihat))
generate iptw=(2*a-1)*y*invwt
generate dr1=iptw+mdiff1
summarize dr1

local dr_est=r(mean)
tempvar I dr_var
generate `I´=dr-`dr_est´
generate I2=`I´^2
summarize I2

generate `dr_var´=r(mean)/1000
scalar dr_se=sqrt(`dr_var´)
display dr_se

******************* (Apllication du dofile)*********
logit D1_did i.sexe i.milieu
predict pihat
generate invwt=D1_did/pihat + (1-D1_did)/(1-pihat)
 
histogram pihat, by(a)
regress nombre_éducation D1_did [pweight=invwt]
regress nombre_éducation i.sexe i.milieu if a==1
predict mu1
regress nombre_éducation i.sexe i.milieu if a==0
predict mu0

generate mdiff1=(-(D1_did-pihat)*mu1/pihat)-((D1_did-pihat)*mu0/(1-pihat))
generate iptw=(2*D1_did-1)*nombre_éducation*invwt
generate dr1=iptw+mdiff1
summarize dr1

local dr_est=r(mean) 
***dr_est est l'estimateur robuste**
tempvar I dr_var
generate `I'=dr-`dr_est'
generate I2=`I'^2
summarize I2

generate `dr_var'=r(mean)/1000
scalar dr_se=sqrt(`dr_var'')
display dr_se

