

#Last updated 6/3/2024

#This code works to find all the .mat files in a folder and extract data into a single dataframe. \
#The dataframe can then be written to .CSV  


install.packages('R.matlab')
library(R.matlab)

#set you working directory to the correct folder
#setwd('G:/project files/gravity sims/R code gravity/Falisse_et_al_2022_chris3')
setwd('G:/project files/aging sims')



#get list of files
fileslist<-list.files(pattern='.mat')

#file='Falisse_et_al_2022_job263.mat'
outdat=data.frame()

for (ii in 1:length(fileslist)){
  
file=fileslist[ii]
dat<-readMat(file)


IG.pelvis <- as.numeric(dat$model.info[[7]])
# OS_path   
Model_info <-as.data.frame(dat$R[9][1])
Model_mass <- as.numeric(Model_info[1,1]) #kilograms
Model_weight <- as.numeric(Model_info[2,1]) #newtons

Spatiotemp<-as.data.frame(dat$R[11])
Step_length<-as.numeric(Spatiotemp$X1.1[10])
Step_length_R<-as.numeric(Spatiotemp$X1.1[1])
Step_length_L<-as.numeric(Spatiotemp$X1.1[2])
Duty_factor_R<-as.numeric(Spatiotemp$X1.1[3])/100
Duty_factor_L<-as.numeric(Spatiotemp$X1.1[5])/100
Double_support<-as.numeric(Spatiotemp$X1.1[7])
Stride_freq<-as.numeric(Spatiotemp$X1.1[8])
Speed<-Step_length/(1/Stride_freq)

#R.S.Subject == target speed


COT<-dat$R[,,1]$metabolics[,,1]$Bhargava2004[,,1]$COT[1]


GRF_dat<-dat$R[8][1]
#3 is the GRF of the right foot
#4 is the GRF of the left foot
#5 is the GR_Moment of the right foot
#6 is the GR_Moment of the left foot
#7 is the COP of the right foot
#8 is the COP of the left foot

#gets the GRFs for the right foot
GRF_R<-GRF_dat[[1]][3]
#gets the GRFs for the left foot
GRF_L<-GRF_dat[[1]][4]

#1 = fore-aft, 2 = vert, 3 = lateral

# plot(GRF_R[[1]][,1],type='l', main='fore-aft GRF right')
# plot(GRF_R[[1]][,2],type='l', main='Vert GRF right')
# plot(GRF_R[[1]][,3],type='l', main='lateral GRF right')
# abline(h=0)

GRFvert_R_max = max(GRF_R[[1]][,2])
GRFvert_R_min = min(GRF_R[[1]][,2])

GRFvert_L_max = max(GRF_L[[1]][,2])
GRFvert_L_min = min(GRF_L[[1]][,2])

GRFfore_R_max = max(GRF_R[[1]][,1])
GRFfore_R_min = min(GRF_R[[1]][,1])

GRFfore_L_max = max(GRF_L[[1]][,1])
GRFfore_L_min = min(GRF_L[[1]][,1])



#############################
#check if MTU are scaled
#############################
# 'soleus_r'
# 'lat_gas_r'
# 'med_gas_r'


model_dat <- dat$model.info
#print(model_dat)
muscle.info <- model_dat[,,1][3]
#print(muscle.info)
parameters<-muscle.info$muscle.info[,,1]

med_gas_r<-parameters[[3]][,,32]
med_gas_r_tendon<-med_gas_r$tendon.stiff.shift[1]
med_gas_r_muscle<-med_gas_r$muscle.strength[1]

lat_gas_r<-parameters[[3]][,,33]
lat_gas_r_tendon<-lat_gas_r$tendon.stiff.shift[1]
lat_gas_r_muscle<-lat_gas_r$muscle.strength[1]

soleus_r<-parameters[[3]][,,34]
soleus_r_tendon<-soleus_r$tendon.stiff.shift[1]
soleus_r_muscle<-soleus_r$muscle.strength[1]



#build data frame

dat_temp<- data.frame(file=file, 
                      Step_length_R=Step_length_R, 
                      Duty_factor_R=Duty_factor_R, 
                      Stride_freq=Stride_freq, 
                      Speed=Speed,
                      COT=COT,
                      GRFvert_R_max = GRFvert_R_max,
                      GRFvert_R_min = GRFvert_R_min,
                      GRFfore_R_max = GRFfore_R_max,
                      GRFfore_R_min = GRFfore_R_min,
                      med_gas_r_tendon=med_gas_r_tendon,
                      med_gas_r_muscle=med_gas_r_muscle,
                      lat_gas_r_tendon=lat_gas_r_tendon,
                      lat_gas_r_muscle=lat_gas_r_muscle,
                      soleus_r_tendon=soleus_r_tendon,
                      soleus_r_muscle=soleus_r_muscle)

outdat<-rbind(outdat,dat_temp)


}


write.csv(outdat, 'compiled_results_04_03_2024.csv')





#COORD names order

# 'pelvis_tilt'
# 'pelvis_list'
# 'pelvis_rotation'
# 'pelvis_tx'
# 'pelvis_ty'
# 'pelvis_tz'
# 'hip_flexion_r'
# 'hip_adduction_r'
# 'hip_rotation_r'
# 'knee_angle_r'
# 'ankle_angle_r'
# 'subtalar_angle_r'
# 'mtp_angle_r'
# 'hip_flexion_l'
# 'hip_adduction_l'
# 'hip_rotation_l'
# 'knee_angle_l'
# 'ankle_angle_l'
# 'subtalar_angle_l'
# 'mtp_angle_l'
# 'lumbar_extension'
# 'lumbar_bending'
# 'lumbar_rotation'
# 'arm_flex_r'
# 'arm_add_r'
# 'arm_rot_r'
# 'elbow_flex_r'
# 'arm_flex_l'
# 'arm_add_l'
# 'arm_rot_l'
# 'elbow_flex_l'
# 

#Muscle names (92)

#'glut_med1_r'	'glut_med2_r'	'glut_med3_r'	'glut_min1_r'	'glut_min2_r'	'glut_min3_r'	'semimem_r'	'semiten_r'	'bifemlh_r'	'bifemsh_r'	'sar_r'	'add_long_r'	'add_brev_r'	'add_mag1_r'	'add_mag2_r'	'add_mag3_r'	'tfl_r'	'pect_r'	'grac_r'	'glut_max1_r'	'glut_max2_r'	'glut_max3_r'	'iliacus_r'	'psoas_r'	'quad_fem_r'	'gem_r'	'peri_r'	'rect_fem_r'	'vas_med_r'	'vas_int_r'	'vas_lat_r'	'med_gas_r'	'lat_gas_r'	'soleus_r'	'tib_post_r'	'flex_dig_r'	'flex_hal_r'	'tib_ant_r'	'per_brev_r'	'per_long_r'	'per_tert_r'	'ext_dig_r'	'ext_hal_r'	'glut_med1_l'	'glut_med2_l'	'glut_med3_l'	'glut_min1_l'	'glut_min2_l'	'glut_min3_l'	'semimem_l'	'semiten_l'	'bifemlh_l'	'bifemsh_l'	'sar_l'	'add_long_l'	'add_brev_l'	'add_mag1_l'	'add_mag2_l'	'add_mag3_l'	'tfl_l'	'pect_l'	'grac_l'	'glut_max1_l'	'glut_max2_l'	'glut_max3_l'	'iliacus_l'	'psoas_l'	'quad_fem_l'	'gem_l'	'peri_l'	'rect_fem_l'	'vas_med_l'	'vas_int_l'	'vas_lat_l'	'med_gas_l'	'lat_gas_l'	'soleus_l'	'tib_post_l'	'flex_dig_l'	'flex_hal_l'	'tib_ant_l'	'per_brev_l'	'per_long_l'	'per_tert_l'	'ext_dig_l'	'ext_hal_l'	'ercspn_r'	'ercspn_l'	'intobl_r'	'intobl_l'	'extobl_r'	'extobl_l'
