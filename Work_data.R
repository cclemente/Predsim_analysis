
Work_data <- function(dat){
  
  
#first get time varying power at each joint
#power is force times velocity. 

#'hip_flexion_r' (7)
Hip_flex_moment <- dat$R[,,1]$kinetics[,,1]$T.ID[,7]
Hip_flex_vel <- dat$R[,,1]$kinematics[,,1]$Qdots.rad[,7]
Hip_power <- Hip_flex_moment*Hip_flex_vel
time <- dat$R[,,1]$time[,,1]$mesh.GC[1:100]
Hip_work_total <-trapz(time, Hip_power)

#negative work
Hip_power_neg <- Hip_power[which(Hip_power<0)]
Hip_work_neg <-trapz(time[1:length(Hip_power_neg)], Hip_power_neg)

#positive work
Hip_power_pos <- Hip_power[which(Hip_power>0)]
Hip_work_pos <-trapz(time[1:length(Hip_power_pos)], Hip_power_pos)




#'Knee_angle_r' (10)
knee_flex_moment <- dat$R[,,1]$kinetics[,,1]$T.ID[,10]
knee_flex_vel <- dat$R[,,1]$kinematics[,,1]$Qdots.rad[,7]
knee_power <- knee_flex_moment*knee_flex_vel
time <- dat$R[,,1]$time[,,1]$mesh.GC[1:100]
knee_work_total <-trapz(time, knee_power)

#negative work
knee_power_neg <- knee_power[which(knee_power<0)]
knee_work_neg <-trapz(time[1:length(knee_power_neg)], knee_power_neg)

#positive work
knee_power_pos <- knee_power[which(knee_power>0)]
knee_work_pos <-trapz(time[1:length(knee_power_pos)], knee_power_pos)




#'Ankle_angle_r' (11)
ankle_flex_moment <- dat$R[,,1]$kinetics[,,1]$T.ID[,11]
ankle_flex_vel <- dat$R[,,1]$kinematics[,,1]$Qdots.rad[,7]
ankle_power <- ankle_flex_moment*ankle_flex_vel
time <- dat$R[,,1]$time[,,1]$mesh.GC[1:100]
ankle_work_total <-trapz(time, ankle_power)

#negative work
ankle_power_neg <- ankle_power[which(ankle_power<0)]
ankle_work_neg <-trapz(time[1:length(ankle_power_neg)], ankle_power_neg)

#positive work
ankle_power_pos <- ankle_power[which(ankle_power>0)]
ankle_work_pos <-trapz(time[1:length(ankle_power_pos)], ankle_power_pos)




#total external work for a single leg

#1. W = Fd (force in direction of travel, displacement)
#2. horizontal GRF integrated to get net pos and neg
#3. net propulsive force = F in direction of travel (I guess?)

Disp_total<-dat$R[,,1]$spatiotemp[,,1]$dist.trav[1]

Fore_aft_R <-dat$R[,,1]$ground.reaction[,,1]$GRF.r[,1]
Fore_aft_L <-dat$R[,,1]$ground.reaction[,,1]$GRF.l[,1]
# plot(Fore_aft_R)
# lines(Fore_aft_L)
# lines(GRF_total_Fore_aft, col='red')

GRF_total_Fore_aft<-rowSums(data.frame(Fore_aft_R,Fore_aft_L))
#time <- dat$R[,,1]$time[,,1]$mesh.GC[1:100]
#force_total <- trapz(time, GRF_total_Fore_aft)
force_total <- sum(GRF_total_Fore_aft)
Ext_work <- force_total*Disp_total


dat_out<-data.frame(Ext_work, 
                    Hip_work_total,Hip_work_neg, Hip_work_pos,
                    knee_work_total,knee_work_neg, knee_work_pos,
                    ankle_work_total,ankle_work_neg, ankle_work_pos)


}
