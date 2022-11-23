library(calecopal)
#To install above package: devtools::install_github("an-bui/calecopal")
library(MetBrewer)
#make ggplot prettier

MetBrewer::colorblind_palettes

ggplot <- function(...) { ggplot2::ggplot(...) + 
    theme(panel.background = element_rect(fill='white', colour='black'), # Make background white and border black
          panel.grid.major = element_blank(),  # Hide major gridlines
          panel.grid.minor = element_blank()) # Hide minor gridlines
}

#Joes Colors: 
color_noceco <-  scale_color_manual(values = c('black', '#BD282F', '#FDD358', '#87B37A', '#5D5D81')) 
color_many2 <- scale_color_manual(values = c('black', '#BD282F', '#EE8739', '#FDD358', '#87B37A', '#5D5D81'))

#Met Brewer Colors

color_many <- scale_color_manual(values = met.brewer("Tam", 6, direction = -1, type = "discrete")) 

color_two <- scale_color_manual(values = met.brewer("Tam", 4 ,direction = -1)) 

color_fill <- scale_fill_manual(values = met.brewer("Tam"))

color_grad <- scale_color_gradientn(colors=met.brewer("Tam", direction = -1))

color_all <- scale_color_manual(values = met.brewer("Tam", direction = -1, type = "discrete")) 

axis_size <- theme(axis_text = element_text(size = 24))
