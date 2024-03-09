

#Last updated 9/3/2024
#now includes subfunctions which get called up. 

#This code works to find all the .mat files in a folder and extract data into a single dataframe. \
#The dataframe can then be written to .CSV  

#install.packages('R.matlab')

library(R.matlab)
#for trapz function (used in EMA calculation)
library(pracma)


#this folder should be where the R code and functions are stored 
setwd('G:/project files/aging sims')
source('MTU_data.R')
source('GRF_data.R')
source('ST_data.R')
source('EMA_data.R')
source('Work_data.R')

#this folder should be where the Raw data (.mat files) are stored 
#setwd('G:/project files/gravity sims/R code gravity/Falisse_et_al_2022_chris3')
setwd('G:/project files/aging sims/raw data')

#get list of files
fileslist<-list.files(pattern='.mat')

#an example if you want a single file
#file='Falisse_et_al_2022_job263.mat'
ii=1
outdat=data.frame()

for (ii in 1:length(fileslist)){
  
file=fileslist[ii]
dat<-readMat(file)

#An example of how to view the data structure in R 
#dat2<-dat$R
#print(dat2)


#############################
# Spatiotemp data
#############################

#return spatio_temporial data
dat_temp1<- ST_data(dat)

#############################
# GROUND reaction forces 
#############################

#returns the GRF data max mnd mins 
dat_temp2<-GRF_data(dat)

#############################
#MTU are scaling
#############################

#call the MTU_data.R function that extracts the following 
# 'soleus_r'
# 'lat_gas_r'
# 'med_gas_r'
#note only works with human model

dat_temp3<-MTU_data(dat)

#############################
#  EMA
#############################


#call the EMA_data function, needs the model weight in Newtons. 
dat_temp4<-EMA_data(dat,dat_temp1$Model_weight)

#############################
#  Joint work, total external work
#############################

#returns the work data 
dat_temp5<-Work_data(dat)



#############################
#  Build final data frame for export
#############################

dat_temp_final<- cbind(dat_temp1,dat_temp2,dat_temp3,dat_temp4,dat_temp5)

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
