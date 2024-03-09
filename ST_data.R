

ST_data <- function(dat){


IG.pelvis <- dat$model.info[,,1]$IG.pelvis.y[1]

# OS_path   
Model_mass <- dat$R[,,1]$misc[,,1]$body.mass[1]#kilograms
Model_weight <- dat$R[,,1]$misc[,,1]$body.weight[1]#newtons


#Spatiotemp<-as.data.frame(dat$R[11])
Step_length<-dat$R[,,1]$spatiotemp[,,1]$dist.trav[1]
Step_length_R<-dat$R[,,1]$spatiotemp[,,1]$step.length.r
Step_length_L<-dat$R[,,1]$spatiotemp[,,1]$step.length.l
Duty_factor_R<-dat$R[,,1]$spatiotemp[,,1]$stance.r[1]/100
Duty_factor_L<-dat$R[,,1]$spatiotemp[,,1]$stance.l[1]/100

Double_support<-dat$R[,,1]$spatiotemp[,,1]$double.support[1]
Stride_freq<-dat$R[,,1]$spatiotemp[,,1]$stride.freq[1]
Speed<-Step_length/(1/Stride_freq)

#R.S.Subject == target speed
Target_speed <- dat$R[,,1]$S[,,1]$subject[,,1]$v.pelvis.x.trgt[1]
#COST of transport
COT<-dat$R[,,1]$metabolics[,,1]$Bhargava2004[,,1]$COT[1]
#convert to metabolic rate (units in ml02/g/hr)
Meta<-COT*Speed*3600/1000/20.1

Stride_time <- max(dat$R[,,1]$time[,,1]$mesh.GC)


dat_temp1<- data.frame(file=file, 
                       Pelvis_height = IG.pelvis,
                       Model_mass = Model_mass,
                       Model_weight = Model_weight,
                       Step_length_R=Step_length_R, 
                       Step_length_L=Step_length_L,
                       Duty_factor_R=Duty_factor_R, 
                       Duty_factor_L=Duty_factor_L,
                       Stride_freq=Stride_freq, 
                       Stride_time = Stride_time,
                       Target_speed=Target_speed,
                       Speed=Speed,
                       COT=COT,
                       Meta=Meta)
return(dat_temp1)
                                              
}