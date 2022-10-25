
####JOE'S COMMENTS:####

#This took a while to get running, but I think it works well now
#I had to use base plot to get it to work

###Note: x.variable and y.variable must be inputted as character strings

#I split the function into two so that we could customize the plots for LFM and MPa separately
#and also make the lines of code shorter and neater by involving more default values for arguments in the function

#####LFM######

rsegplot.lfm <- function(model, dataframe, species, x.variable = 'lfm', y.variable, max.x = max.lfm, x.lab = 'Live Fuel Moisture (%)', y.lab = NULL, tlp = NULL, tlp.upper = NULL, tlp.lower = NULL, color = 'color') {
  
  p <- summary.segmented(model)$psi[2]
  m <- slope(model, .coef = fixef(model))[[1]][[1]]
  b <- intercept(model, .coef = fixef(model))[[1]][[1]]
  m2 <- slope(model, .coef = fixef(model))[[1]][[2]]
  b2 <- intercept(model, .coef = fixef(model))[[1]][[2]]
  yvar <- dataframe[,y.variable]
  xvar <- dataframe[,x.variable]
  colr <- dataframe[,color]
  confint <- confint.segmented(model, x.variable, .coef=fixef(model))
  lower <- confint[2]
  upper <- confint[3]
  ymax <- max(yvar)
  ymin <- min(yvar)
  
  wacky <- plot(xvar, yvar, xlim = c(0, max.x), ylim = c(ymin-0.05*ymin, ymax+0.05*ymax), 
                xlab = x.lab, ylab = y.lab,
                pch = 16, col = alpha(colr, 0.8),
                cex.lab = 1.3)
  polygon(x = c(lower, upper, upper, lower), y = c(ymax + 0.2*ymax, ymax +0.2*ymax, ymin - 30, ymin - 30), col = alpha('gray', 0.3), lty = 2)
  abline(v = tlp, col = alpha('#00C368', 0.7), cex = 3)
  polygon(x = c(tlp.lower, tlp.upper, tlp.upper, tlp.lower), y = c(ymax +0.2*ymax, ymax +0.2*ymax, ymin -30, ymin -30), col = alpha('#00C368', 0.3), border = alpha('#00C368', 0.6))
  legend('topleft', legend=if(species == 'ADFA'){
    c("September 2020", "January 2018", "December 2016")
  }
  else if(species == 'CEME'){
    c("September 2020", "January 2020", "December 2019")
  },
  col=if(species == "ADFA") {
    c("#c1121f","#FF7262","#A4A7DE")
  }
  else if(species == "CEME") {
    c("#c1121f","#64A400","#669BBC")
  }, pch = 16, cex=1)
  for(z in 1:length(xvar)){
    if(z < p){
      segments(x0 = 0, x1 = p, y0 = b, y1 = m*((b2 - b)/(m - m2))+b, lwd = 3, col = "#9D0208")
    }else{
      segments(x0 = p, x1 = max.x, y0 = m2*((b - b2)/(m2 - m))+b2 , y1 = m2*max.x + b2, lwd = 3, col = "#9D0208")}}
  return(wacky)
}


####MPA####

rsegplot.mpa <- function(model, dataframe, species, x.variable = 'mpa', y.variable, max.x = max.mpa, x.lab = 'Water Potential (MPa)', y.lab = NULL, tlp = NULL, tlp.upper = NULL, tlp.lower = NULL, color = 'color') 
{
  p <- summary.segmented(model)$psi[2]
  m <- slope(model, .coef = fixef(model))[[1]][[1]]
  b <- intercept(model, .coef = fixef(model))[[1]][[1]]
  m2 <- slope(model, .coef = fixef(model))[[1]][[2]]
  b2 <- intercept(model, .coef = fixef(model))[[1]][[2]]
  yvar <- dataframe[,y.variable]
  xvar <- dataframe[,x.variable]
  colr <- dataframe[,color]
  confint <- confint.segmented(model, x.variable, .coef=fixef(model))
  lower <- confint[2]
  upper <- confint[3]
  ymax <- max(yvar)
  ymin <- min(yvar)
  
  wacky <- plot(xvar, yvar, xlim = c(-10, 0), ylim = c(ymin-1, ymax+1), 
                xlab = x.lab, ylab = y.lab,
                pch = 16, col = colr, cex.lab = 1.1)
  polygon(x = c(lower, upper, upper, lower), y = c(ymax +1.5, ymax +1.5, ymin -1.5, ymin -1.5), col = alpha('gray', 0.3), lty = 2)
  abline(v = tlp, col = alpha('#00C368', 0.8), cex = 3)
  polygon(x = c(tlp.lower, tlp.upper, tlp.upper, tlp.lower), y = c(ymax +1.5, ymax +1.5, ymin -1.5, ymin -1.5), col = alpha('#00C368', 0.3), border = alpha('#00C368', 0.7))
  abline(a = b, b = m, lwd = 3, col = "#9D0208")
  legend(-2, ymax+0.05*ymax, legend=if(species == 'ADFA'){
    c("September 2020", "January 2018", "December 2016")
  }
  else if(species == 'CEME'){
    c("September 2020", "January 2020", "December 2019")
  },
  col=if(species == "ADFA") {
    c("#c1121f","#FF7262","#A4A7DE")
  }
  else if(species == "CEME") {
    c("#c1121f","#64A400","#669BBC")
  }, pch = 16, cex=0.8)
  for(j in 1:length(xvar)){
    if(j < p){
      segments(x0 = -10, x1 = p, y0 = (-10*m) + b , y1 = m2*((b - b2)/(m2 - m))+b2, lwd = 3, col = "#9D0208")
    }
    else{
      segments(x0 = p, x1 = max.x, y0 = m2*((b - b2)/(m2 - m))+b2, y1 = b2, lwd = 3, col = "#9D0208")
    }
  }
  return(wacky)
}



#####For splitting by sampling date: no legend!#####



rsegplot.lfm.nolegend <- function(model, dataframe, species, x.variable = 'lfm', y.variable, max.x = max.lfm, x.lab = 'Live Fuel Moisture (%)', y.lab = NULL, tlp = NULL, tlp.upper = NULL, tlp.lower = NULL, color = 'color') {
  
  p <- summary.segmented(model)$psi[2]
  m <- slope(model, .coef = fixef(model))[[1]][[1]]
  b <- intercept(model, .coef = fixef(model))[[1]][[1]]
  m2 <- slope(model, .coef = fixef(model))[[1]][[2]]
  b2 <- intercept(model, .coef = fixef(model))[[1]][[2]]
  yvar <- dataframe[,y.variable]
  xvar <- dataframe[,x.variable]
  colr <- dataframe[,color]
  confint <- confint.segmented(model, x.variable, .coef=fixef(model))
  lower <- confint[2]
  upper <- confint[3]
  ymax <- max(yvar)
  ymin <- min(yvar)
  
  wacky <- plot(xvar, yvar, xlim = c(0, max.x), ylim = c(ymin-0.05*ymin, ymax+0.05*ymax), 
                xlab = x.lab, ylab = y.lab,
                pch = 16, col = alpha(colr, 0.8),
                cex.lab = 1.3)
  polygon(x = c(lower, upper, upper, lower), y = c(ymax + 0.2*ymax, ymax +0.2*ymax, ymin - 30, ymin - 30), col = alpha('gray', 0.3), lty = 2)
  abline(v = tlp, col = alpha('#00C368', 0.7), cex = 3)
  polygon(x = c(tlp.lower, tlp.upper, tlp.upper, tlp.lower), y = c(ymax +0.2*ymax, ymax +0.2*ymax, ymin -30, ymin -30), col = alpha('#00C368', 0.3), border = alpha('#00C368', 0.6))
  for(z in 1:length(xvar)){
    if(z < p){
      segments(x0 = 0, x1 = p, y0 = b, y1 = m*((b2 - b)/(m - m2))+b, lwd = 3, col = "#9D0208")
    }else{
      segments(x0 = p, x1 = max.x, y0 = m2*((b - b2)/(m2 - m))+b2 , y1 = m2*max.x + b2, lwd = 3, col = "#9D0208")}}
  return(wacky)
}