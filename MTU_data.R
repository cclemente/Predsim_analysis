


MTU_data <- function(dat){
  default_stiffness = 35
  
  med_gas_r<-dat$model.info[,,1]$muscle.info[,,1]$parameters[,,32]
  med_gas_r_tendon<-med_gas_r$tendon.stiff[1]/default_stiffness
  med_gas_r_muscle<-med_gas_r$muscle.strength[1]
  
  lat_gas_r<-dat$model.info[,,1]$muscle.info[,,1]$parameters[,,33]
  lat_gas_r_tendon<-lat_gas_r$tendon.stiff[1]/default_stiffness
  lat_gas_r_muscle<-lat_gas_r$muscle.strength[1]
  
  soleus_r<-dat$model.info[,,1]$muscle.info[,,1]$parameters[,,34]
  soleus_r_tendon<-soleus_r$tendon.stiff[1]/default_stiffness
  soleus_r_muscle<-soleus_r$muscle.strength[1]
  
  
  dat_temp3<- data.frame(med_gas_r_tendon=med_gas_r_tendon,
                         med_gas_r_muscle=med_gas_r_muscle,
                         lat_gas_r_tendon=lat_gas_r_tendon,
                         lat_gas_r_muscle=lat_gas_r_muscle,
                         soleus_r_tendon=soleus_r_tendon,
                         soleus_r_muscle=soleus_r_muscle)
  
  return(dat_temp3)
  
}
