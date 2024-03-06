
#edited 6/3/2024

#This code takes the output from 
#https://github.com/cclemente/Predsim_analysis/blob/main/Pred_sim_loop_data_capture.R
#and makes some graphs 

#set the WD
setwd('G:/project files/aging sims')

#read the data
dat<-read.csv('compiled_results_04_03_2024.csv')

table(as.factor(dat$med_gas_r_muscle))
table(as.factor(dat$lat_gas_r_tendon))
#remove muscle 1.12

dat<-dat[-which(dat$med_gas_r_muscle==1.12),]

#make the COT plot, but separate the points so they dont overlap
dat$Speed2<-jitter(dat$Speed,100)
plot(COT~Speed2, dat, pch=20, col=as.factor(dat$med_gas_r_tendon), cex=dat$med_gas_r_muscle*2)

#GAM plots which each condition separate? 
#-to do



#heat maps 
library(lattice)
#library(viridis)
#library(ggplot2)
library(tidyverse)
#library(hrbrthemes)
#hrbrthemes::import_roboto_condensed()

#df1<-data.frame(Dist=all_data5$Perc_slip, Fore=all_data5$Wrist_Fore, Hind=all_data5$Wrist_Hind)
df1<-data.frame(COT=dat$COT, muscle=dat$med_gas_r_muscle, tendon=round(dat$med_gas_r_tendon, digits = 3))


#creates a matrix
df2<-with(df1, tapply(COT, list(muscle = muscle, tendon), FUN= mean, na.rm=TRUE))
df2_rev<-apply(df2, 2, rev)

#CREATE OWN COLOURMAP
#colours_heat2 goes from darkblue via lightblue via light orange to dark orange => hotspots (HIGH values) are orange
colours_heat2 = c('#07004F', '#445DAA', '#89B2DB', '#B3EAFF', '#D0FCFC', '#F9EADE', '#F7D5BC', '#FFB98A', '#ED7D29', '#C12900')
#reversed colourmap so that LOW values are displayed as orange hotspot
colours_heat2_reversed = rev(colours_heat2)

#LATTICE PLOT
#use for HIGH VALUES = hotspot
levelplot(df2, cex.axis=1.5, cex.lab=1.5, col.regions=colorRampPalette(colours_heat2), 
          xlab=list(label='Muscle', cex = 1.8),
          ylab=list(label='tendon', cex = 1.8),
          main=list(label='COT', cex=1.8), 
          colorkey=list(labels=list(cex=1.8)),
          scales = list(cex=1.8),
          asp=1)

#use for LOW VALUES = hotspot == colours_heat2_reversed



#Tendon stiffness vs speed - tendons have little effect
df1<-data.frame(COT=dat$COT, Speed=round(dat$Speed, digits = 1), tendon=round(dat$med_gas_r_tendon, digits = 3))
#creates a matrix
df2<-with(df1, tapply(COT, list(Speed = Speed, tendon), FUN= mean, na.rm=TRUE))
levelplot(df2, cex.axis=1.5, cex.lab=1.5, col.regions=colorRampPalette(colours_heat2),
          xlab='Speed', ylab='Tendon', main='COT', asp=1)


#muscle effects - hot spot. nice. 
df1<-data.frame(COT=dat$COT, Speed=round(dat$Speed, digits = 1), muscle=dat$med_gas_r_muscle)
#creates a matrix
df2<-with(df1, tapply(COT, list(Speed = Speed, muscle), FUN= mean, na.rm=TRUE))
levelplot(df2, cex.axis=1.5, cex.lab=1.5, col.regions=colorRampPalette(colours_heat2),
          xlab='Speed', ylab='muscle', main='COT', asp=1)



##Stride parameters 

dat$Speed2<-jitter(dat$Speed,100)
par(mfrow = c(2, 2))
#plot 1 - stride length
plot(Step_length_R~Speed2, dat, pch=20, col=as.factor(dat$med_gas_r_tendon), 
     cex=dat$med_gas_r_muscle*2, main='Stride length')
#plot 2 - stride freq
plot(Stride_freq~Speed2, dat, pch=20, col=as.factor(dat$med_gas_r_tendon), 
     cex=dat$med_gas_r_muscle*2, main='Stride freq')
#plot 3 - Duty factor
plot(Duty_factor_R~Speed2, dat, pch=20, col=as.factor(dat$med_gas_r_tendon), 
     cex=dat$med_gas_r_muscle*2, main='Duty (lol)')
#plot 4 - Contact time
dat$contact_time<-(1/dat$Stride_freq)*dat$Duty_factor_R
plot(contact_time~Speed2, dat, pch=20, col=as.factor(dat$med_gas_r_tendon), 
     cex=dat$med_gas_r_muscle*2, main='Contact time')



