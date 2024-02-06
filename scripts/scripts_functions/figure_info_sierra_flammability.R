library(calecopal)
#To install above package: 
  #devtools::install_github("an-bui/calecopal")
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
color_many2 <- scale_color_manual(values = c('#42401D', '#5DA493', '#D8AB43', '#5792CC', '#C75146', '#6E406E'))

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
  vcol <-  c(age_new_num = "#fac228", 
             age_new = "#fac228", 
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
  
  #
  ### Function

  ES.plot <- function(df, y.var, sig, std.error, mpa = 'no', margins.vector = c(0.1, 0.1, 0.1, 0.1), limits.vector, breaks.vector, axis.title = ' ') 
  { if(mpa == 'no'){
    ggplot(data = df, aes(x = species, y = y.var,
                          color = species, shape = sig)) +
      labs(color = 'Species', shape = 'Significant?') +
      geom_point(size = 5) +
      geom_linerange(aes(ymin = y.var - 0.5*std.error, ymax = y.var + 0.5*std.error)) +
      geom_abline(intercept = 0, slope = 0, color = 'black', alpha = 0.5, size = 0.3) +
      theme_bw() +
      scale_y_continuous(limits = limits.vector, breaks = breaks.vector) +
      color_noceco+
      #scale_color_manual(values = c('black', '#FDD358', 'black', 'black', '#FDD358')) + # For color by angio vs gymno (version 1)
      scale_shape_manual(values = c(10, 16)) +
      # geom_vline(xintercept = 3.4, alpha = 0.5, size = 0.3, lty = 2) +
      # annotate(geom = "text", x = 2, y = 14, label = 'Gymnosperms', size = 4) +
      # annotate(geom = "text", x = 4.52, y = 14, label = 'Angiosperms', size = 4) +
      theme(axis.title.x = element_blank(), 
            axis.text.x = element_blank(),
            axis.title.y = element_blank(), 
            axis.text.y = element_blank(),
            axis.ticks.y = element_blank(),
            legend.title = element_text(face = 'bold', size = 14),
            legend.text = element_text(face = 'italic'),
            panel.grid = element_blank(), axis.ticks.x = element_blank(),
            plot.title = element_text(hjust = 0.5, face = 'bold', size = 14),
            plot.margin = unit(margins.vector, 'cm'),
            legend.position = 'none')
  }
    else{
      ggplot(data = df, aes(x = species, y = y.var,
                            color = species, shape = sig)) +
        labs(color = 'Species', shape = 'Significant?') +
        geom_point(size = 5) +
        geom_linerange(aes(ymin = y.var - 0.5*std.error, ymax = y.var + 0.5*std.error)) +
        geom_abline(intercept = 0, slope = 0, color = 'black', alpha = 0.5, size = 0.3) +
        theme_bw() +
        scale_y_continuous(limits = limits.vector, breaks = breaks.vector,
                           sec.axis = sec_axis(trans = ~.*1, 
                                               name = axis.title,
                                               breaks = breaks.vector,
                                               labels = breaks.vector)) +
        color_noceco+
        #scale_color_manual(values = c('black', '#FDD358', 'black', 'black', '#FDD358')) + # For color by angio vs gymno (version 1)
        scale_shape_manual(values = c(10, 16)) +
        # geom_vline(xintercept = 3.4, alpha = 0.5, size = 0.3, lty = 2) +
        # annotate(geom = "text", x = 2, y = 14, label = 'Gymnosperms', size = 4) +
        # annotate(geom = "text", x = 4.52, y = 14, label = 'Angiosperms', size = 4) +
        theme(axis.title.x = element_blank(), 
              axis.text.x = element_blank(),
              axis.ticks.y.left = element_blank(), 
              axis.title.y.left = element_blank(),
              axis.text.y.left = element_blank(),
              axis.title.y.right = element_text(face = 'bold', size = 14),
              axis.text.y.right = element_text(size = 12),
              legend.title = element_text(face = 'bold', size = 14),
              legend.text = element_text(face = 'italic',),
              panel.grid = element_blank(), axis.ticks.x = element_blank(),
              plot.title = element_text(hjust = 0.5, face = 'bold', size = 14),
              plot.margin = unit(margins.vector, 'cm'),
              legend.position = 'none')
    }
  }
