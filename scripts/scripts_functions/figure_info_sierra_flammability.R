library(calecopal)
#To install above package: devtools::install_github("an-bui/calecopal")
library(MetBrewer)
library(tidyverse)
#make ggplot prettier

MetBrewer::colorblind_palettes

ggplot <- function(...) { ggplot2::ggplot(...) + 
    theme(panel.background = element_rect(fill='white', colour='black'), # Make background white and border black
          panel.grid.major = element_blank(),  # Hide major gridlines
          panel.grid.minor = element_blank()) # Hide minor gridlines
}

#Joes Colors: 
# In this order: ABCO, PIJE, CADE, ARPA, CECO (if present), QUKE
color_noceco <-  scale_color_manual(values = c('#42401D', '#5DA493', '#D8AB43', '#5792CC', '#6E406E')) 
fill_noceco <-  scale_fill_manual(values = c('#42401D', '#5DA493', '#D8AB43', '#5792CC', '#6E406E')) 
color_many2 <- scale_color_manual(values = c('#42401D', '#5DA493', '#D8AB43', '#5792CC', '#4D5B75', '#6E406E'))

#Calecopal Colors
sierra1 = c("#BD973D", "#5F5C29", "#3B7D6E", "#5792CC", "#4D5B75", "#262E43")

#To get more colors, if needed:
nb.cols.10 <- 1
pal.10 <- cal_palette("sierra1")
mycolors.10 <- colorRampPalette(pal.10)(nb.cols.10)

color_many <- scale_color_manual(values = cal_palette("sierra1", 6, #direction = -1, 
                                                      type = "discrete")) 

color_two <- scale_color_manual(values = cal_palette("sierra1", 4 
                                                     #direction = -1)
                                                     ))

color_fill <- scale_fill_manual(values = cal_palette("sierra1"))

color_grad <- scale_color_gradientn(colors=cal_palette("sierra1", 
                                                       #direction = -1)
                                                       ))

color_all <- scale_color_manual(values = cal_palette("sierra1", 
                                                     #direction = -1, 
                                                     type = "discrete")) 

axis_size <- theme(axis_text = element_text(size = 24))


#variance decomp colors: 
  vcol <-  c(age_new = "#fac228", 
             spp = "#9f2a63", 
             year = "#d44842", 
             year_month = "#d44842",
             water_potential = "#280b53", 
             plant = "#65156e", 
            # F.Group = "gold", 
             Residuals = "grey")

#Met Brewer Colors

# color_many <- scale_color_manual(values = met.brewer("sierra1", 6, direction = -1, type = "discrete")) 
# 
# color_two <- scale_color_manual(values = met.brewer("sierra1", 4 ,direction = -1)) 
# 
# color_fill <- scale_fill_manual(values = met.brewer("sierra1"))
# 
# color_grad <- scale_color_gradientn(colors=met.brewer("sierra1", direction = -1))
# 
# color_all <- scale_color_manual(values = met.brewer("sierra1", direction = -1, type = "discrete")) 
# 
# axis_size <- theme(axis_text = element_text(size = 24))
