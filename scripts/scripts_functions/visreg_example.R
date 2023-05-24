install.packages("visreg")

library(visreg)

visreg(top_lfm_tti , "lfm_scaled")+
  scale_y_continuous(limits=c(0,400))


visreg(top_lfm_tti, "spp")
