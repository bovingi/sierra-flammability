
rsegplot.lfm <- function(model, dataframe, x.variable = 'lfm', y.variable, max.x = abco_max_lfm, x.lab = 'Live Fuel Moisture (%)', y.lab = NULL, tlp = NULL, tlp.upper = NULL, tlp.lower = NULL) {
  
  p <- summary.segmented(model)$psi[2]
  m <- slope(model, .coef = fixef(model))[[1]][[1]]
  b <- intercept(model, .coef = fixef(model))[[1]][[1]]
  m2 <- slope(model, .coef = fixef(model))[[1]][[2]]
  b2 <- intercept(model, .coef = fixef(model))[[1]][[2]]
  yvar <- dataframe[[y.variable]]
  xvar <- dataframe[[x.variable]]
  confint <- confint.segmented(model, x.variable, .coef=fixef(model))
  lower <- confint[2]
  upper <- confint[3]
  ymax <- max(yvar)
  ymin <- min(yvar)
  
  wacky <- plot(xvar, yvar, xlim = c(0, max.x), ylim = c(ymin-0.05*ymin, ymax+0.05*ymax), 
                xlab = x.lab, ylab = y.lab,
                pch = 16, col = alpha('black', 0.8),
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


rsegplot.mpa <- function(model, dataframe, x.variable = 'mpa', y.variable, max.x = abco_max_mpa, x.lab = 'Water Potential (MPa)', y.lab = NULL, tlp = NULL, tlp.upper = NULL, tlp.lower = NULL) {
  
  p <- summary.segmented(model)$psi[2]
  m <- slope(model, .coef = fixef(model))[[1]][[1]]
  b <- intercept(model, .coef = fixef(model))[[1]][[1]]
  m2 <- slope(model, .coef = fixef(model))[[1]][[2]]
  b2 <- intercept(model, .coef = fixef(model))[[1]][[2]]
  yvar <- dataframe[[y.variable]]
  xvar <- dataframe[[x.variable]]
  confint <- confint.segmented(model, x.variable, .coef=fixef(model))
  lower <- confint[2]
  upper <- confint[3]
  ymax <- max(yvar)
  ymin <- min(yvar)
  
  wacky <- plot(xvar, yvar, xlim = c(0, max.x), ylim = c(ymin-0.05*ymin, ymax+0.05*ymax), 
                xlab = x.lab, ylab = y.lab,
                pch = 16, col = alpha('black', 0.8),
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
