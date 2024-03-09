
GRF_data <- function(dat){

#GRF_dat<-dat$R[8][1]
#3 is the GRF of the right foot
#4 is the GRF of the left foot
#5 is the GR_Moment of the right foot
#6 is the GR_Moment of the left foot
#7 is the COP of the right foot
#8 is the COP of the left foot

#gets the GRFs for the right foot
GRF_R<-dat$R[,,1]$ground.reaction[,,1]$GRF.r

#gets the GRFs for the left foot
GRF_L<-dat$R[,,1]$ground.reaction[,,1]$GRF.l

#    1 = fore-aft,      2 = vert,       3 = lateral

# plot(GRF_R[[1]][,1],type='l', main='fore-aft GRF right')
# plot(GRF_R[[1]][,2],type='l', main='Vert GRF right')
# plot(GRF_R[[1]][,3],type='l', main='lateral GRF right')
# abline(h=0)

GRFvert_R_max = max(GRF_R[,2])
GRFvert_R_min = min(GRF_R[,2])

GRFvert_L_max = max(GRF_L[,2])
GRFvert_L_min = min(GRF_L[,2])

GRFfore_R_max = max(GRF_R[,1])
GRFfore_R_min = min(GRF_R[,1])

GRFfore_L_max = max(GRF_L[,1])
GRFfore_L_min = min(GRF_L[,1])


dat_temp2<- data.frame(GRFvert_R_max = GRFvert_R_max,
                       GRFvert_R_min = GRFvert_R_min,
                       GRFfore_R_max = GRFfore_R_max,
                       GRFfore_R_min = GRFfore_R_min)

return(dat_temp2)

}
