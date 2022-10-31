
#This is if you want to facet by flam metric and loop through species. 

plot_facet_flam <- function(data, x, y, color_var, facet_var) {
  ggplot(data) +
    geom_point(aes(y = {{y}}, 
                   x = {{x}},
                   # fill = spp, 
                   color = {{color_var}}), 
               alpha = .4) +
    #facet_wrap(enquo({{facet_var}}), scales = "free") 
    facet_wrap(enquo(facet_var), scales = "free") 
}

#Example: 
plot_facet_flam(plot_mpa_df, mpa, value, year_month, flam_metric)