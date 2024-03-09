

EMA_data <- function(dat, Model_weight){

#get integral of GRF
#GRFs for the right foot
Vertical_R <-dat$R[,,1]$ground.reaction[,,1]$GRF.r[,2]
Fore_aft_R <-dat$R[,,1]$ground.reaction[,,1]$GRF.r[,1]
Lateral_R <-dat$R[,,1]$ground.reaction[,,1]$GRF.r[,3]
GRF_total<-sqrt(rowSums(data.frame(Vertical_R^2, Fore_aft_R^2, Lateral_R^2)))
#GRF_total<-GRF_total/100*dat_temp1$Model_weight
GRF_total<-GRF_total/100*Model_weight
GRF_int<-trapz(seq(1:100), GRF_total)


#ankle pflex
#Mgas (32), Lgas (33), Sol (34), tibP (35), fdig (36), fhal (37), perB (39), perL (40)
ankle_pflex <- c(32,33,34,35,36,37,39,40)
ankle_out <- data.frame()



for (ii in 1:length(ankle_pflex)) {
  Fmo<-dat$model.info[,,1]$muscle.info[,,1]$parameters[,,ii]$FMo
  Act<-dat$R[,,1]$muscles[,,1]$Fiso[,ii]
  muscle_force<-Act*rep(Fmo,100)
  ankle_out <- rbind(ankle_out,muscle_force)
  
}

ankle_ext<-colSums(ankle_out)
ankle_int<-trapz(seq(1:100), ankle_ext)
EMA_ankle<-GRF_int/ankle_int



#hip extensors
# Glut_med_3 (1), Glut_min_3 (6), semiM (7), semiT (8), bifemlh (9)
# add_mag1 (14), add_mag2 (15), add_mag3 (16), 
# Glut_max_1 (20), Glut_max_2 (21), Glut_max_3 (22), 

hip_ext <- c(1,6,7,8,9,14,15,16,20,21,22)
hip_out <- data.frame()

for (ii in 1:length(hip_ext)) {
  Fmo<-dat$model.info[,,1]$muscle.info[,,1]$parameters[,,ii]$FMo
  Act<-dat$R[,,1]$muscles[,,1]$Fiso[,ii]
  muscle_force<-rep(Fmo,100)*Act
  hip_out <- rbind(hip_out,muscle_force)
  
}

hip_ext_sum<-colSums(hip_out)
hip_int<-trapz(seq(1:100), hip_ext_sum)
EMA_hip<-GRF_int/hip_int


#knee extensors

# Vas_int (30), Vas_med (29), Vas_lat (31), Rect_fem (28)

knee_ext <- c(28,29,30,31)
knee_out <- data.frame()

for (ii in 1:length(knee_ext)) {
  Fmo<-dat$model.info[,,1]$muscle.info[,,1]$parameters[,,ii]$FMo
  Act<-dat$R[,,1]$muscles[,,1]$Fiso[,ii]
  muscle_force<-rep(Fmo,100)*Act
  knee_out <- rbind(knee_out,muscle_force)
  
}

knee_ext_sum<-colSums(knee_out)
knee_int<-trapz(seq(1:100), knee_ext_sum)
EMA_knee<-GRF_int/knee_int

dat_out<-data.frame(EMA_knee,EMA_ankle, EMA_hip)

return(dat_out)

}
