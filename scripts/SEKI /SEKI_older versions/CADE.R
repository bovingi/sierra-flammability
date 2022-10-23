---
  title: "CADE"
author: "Indra Boving"
date: "3/15/2021"
output: html_document
---
  
```{r setup, include=FALSE}
setwd("~/Desktop")
library(simputation)
library(visdat)
library(ggplot2) 
library(gapminder)
library(data.table)
library(purrr) #for visualizing all variables in one big plot
library(naniar) #deal with NAs
library(dplyr)
library(tidyverse)
library(ggpubr)
filter = dplyr::filter #correct filter problem (gets confused with stats::filter)
library(pvldcurve)
```

```{r}
pressure_volume <- read.csv("pressure_volume_data_NOsatwt.csv") %>%
  mutate(lfm = (((fresh.weight - dry.weight)/dry.weight)* 100)) %>%
  mutate(RWC.excel.allvalues = (100 - RWD.excel))
```

CADE: 

   ```{r eval=FALSE, include=FALSE}
pv.CADE <- pressure_volume %>%
  filter(spp == "CADE")

#It doesn't seem to like this...so I calculated fresh.weight.sat from the usual excel sheet: 
pv.CADE <- FWSaturated(pv.CADE, sample = "sample", water.potential = "water.potential", fresh.weight = "fresh.weight", dry.weight = "dry.weight")

pv.CADE <- RelativeWaterDeficit(pv.CADE)
#str(pv.CADE)

rwc <- TurgorLossPoint(pv.CADE) 
rwc.df <- as.data.frame(rwc)
str(rwc.df)
df_long <- rwc.df %>%
  select("sample.1.RWD", "sample.3.RWD", "sample.4.RWD") %>%
  gather(key = "sample", value = "RWD.TLP",
         "sample.1.RWD", "sample.3.RWD", "sample.4.RWD")

osm.tlp <- OsmoticPot(pv.CADE)
osm.df <- as.data.frame(osm.tlp)
str(osm.df)
df_long <- osm.df %>%
  select("sample.1.turgor.loss.point.RWD", "sample.3.turgor.loss.point.RWD", "sample.4.turgor.loss.point.RWD", "sample.1.turgor.loss.point.water.potential", "sample.3.turgor.loss.point.water.potential", "sample.4.turgor.loss.point.water.potential") %>%
  gather(key = "sample", value = "RWD.TLP",
         "sample.1.turgor.loss.point.RWD", "sample.3.turgor.loss.point.RWD", "sample.4.turgor.loss.point.RWD") %>%
  gather(key = "sample", value = "TLP.mpa", "sample.1.turgor.loss.point.water.potential",  "sample.3.turgor.loss.point.water.potential", "sample.4.turgor.loss.point.water.potential") 
str(df_long)
```

#Getting the necessary values in dataframes so we can use them with predict():

```{r}
mpatlp.r.value <- df_long %>% summarise(mean(TLP.mpa)) %>% pull()
mpatlp.r.value

tlprwd.r.value <- df_long %>% summarise(mean(RWD.TLP)) %>% pull()
tlprwd.r.value

tlprwc.r.value <- sum(100 - tlprwd.r.value) #%>% pull()
tlprwc.r.value
#ModElasticity(pv.CADE)

fit <-lm(lfm~RWD, pv.CADE)
summary(fit)

#tlprwd.r.topredict <- df_long %>% summarise(mean(RWD.TLP)) %>% pull()
#tlprwd.r.topredict
#tlplfm.r.value <- predict.lm(fit, newdata = (RWD = tlprwd.r.topredict)) %>% as.numeric() #use this to extract lfm
#tlplfm.r.value
```

CADE, using TLP and RWC from pvld package: 
  
  ```{r}
pv.CADE <- pv.CADE %>%
  mutate(RWC = 100 - RWD) 

#Do with lfm and RWD: 
fit <-lm(lfm~RWD, pv.CADE)
summary(fit)
#tlprwd.excel <- data.frame(RWD=c(18.20693)) #%>% pull()#RWD at TLP, calculated from PV-template in excel:
#tlprwd.excel.value <- data.frame(RWD= c(18.20693)) %>% pull()
lfm.predicted.r <- predict.lm(fit, newdata = data_frame(RWD = 16.57677)) %>% as.numeric() #use this to extract lfm
lfm.predicted.r

#tlp.mpa <- pv.CADE %>% summarise(mean(TLP.excel)) %>% pull()

rwdXlfm <- pv.CADE %>%
  #filter(sample == 1) %>%
  ggplot(aes(y = lfm, x = RWD, color = dry.weight, add = "reg.line")) + 
  geom_jitter() +
  ggtitle("6") +
  geom_vline(xintercept = tlprwd.r.topredict, linetype="dotted", 
             color = "blue", size=.5) +
  geom_hline(yintercept = lfm.predicted.r, linetype="dotted", 
             color = "blue", size=.5) +
  geom_smooth(method = "lm", size = 0.5, se = FALSE) +
  ylab("LFM") +
  xlab("Relative Water Deficit") + 
  ggtitle("CADE PV Curves") +
  geom_label(label="TLP: -2.38 Mpa",  x=18 ,y=80, label.padding = unit(0.1, "lines"), # Rectangle size around label
             label.size = 0.2, color = "black",fill="light blue") +
  stat_regline_equation(label.x = 1, label.y = 60)
rwdXlfm

fit <-lm(lfm~RWC, pv.CADE)
summary(fit)
tlprwc.value <- data.frame(RWC=c(83.42323)) %>% pull()
tlprwc.excel <- data.frame(RWC=c(83.42323))

rwcXlfm <- pv.CADE %>%
  #filter(sample == 6) %>%
  ggplot(aes(y = lfm, x = RWC, add = "reg.line")) + 
  geom_jitter() +
  ggtitle("6") +
  geom_vline(xintercept = tlprwc.r.value, linetype="dotted", 
             color = "blue", size=.5) +
  geom_hline(yintercept = lfm.predicted.r, linetype="dotted", 
             color = "blue", size=.5) +
  geom_smooth(method = "lm", size = 0.5, se = FALSE) +
  ylab("LFM") +
  xlab("Relative Water Content") + 
  ggtitle("CADE PV Curve/LFM Conversion") +
  geom_label(label="TLP: -2.38 Mpa",  x=82 ,y= 80, label.padding = unit(0.1, "lines"), # Rectangle size around label
             label.size = 0.2, color = "black",fill="light blue") +
  stat_regline_equation(label.x = 70, label.y = 90)
rwcXlfm
```

```{r}
rwd <- pv.CADE %>%
  ggplot(aes(y = -1/water.potential, x = RWD.excel, color = sample)) +
  geom_point()  +
  ggtitle("CADE") +
  geom_vline(xintercept = tlprwd.r.value, linetype="dotted", color = "blue", size=.5)
rwd

lfm <- pv.CADE %>%
  ggplot(aes(y = -1/water.potential, x = lfm, color = sample)) +
  geom_point() +
  scale_x_reverse()  +
  geom_vline(xintercept = lfm.predicted.r, linetype="dotted", color = "blue", size=.5) +
  xlab("LFM")
lfm

rwc <- pv.CADE %>%
  ggplot(aes(y = -1/water.potential, x = RWC.excel.allvalues, color = sample)) +
  geom_point() +
  scale_x_reverse() +
  geom_vline(xintercept = tlprwc.r.value, linetype="dotted", color = "blue", size=.5)
rwc

require(gridExtra)
grid.arrange(rwd, lfm, rwc, ncol = 1, heights = c(1, 1,1)) 
```

Use all excel data
```{r}
#Do with lfm and RWD: 
fit <-lm(lfm~RWD, pv.CADE)
summary(fit)
#tlprwd.excel <- data.frame(RWD=c(18.20693)) #%>% pull()#RWD at TLP, calculated from PV-template in excel:
#tlprwd.excel.value <- data.frame(RWD= c(18.20693)) %>% pull()
lfm.predicted.r <- predict.lm(fit, newdata = data_frame(RWD = 18.20693)) %>% as.numeric() #use this to extract lfm
lfm.predicted.r

#tlp.mpa <- pv.CADE %>% summarise(mean(TLP.excel)) %>% pull()

rwdXlfm <- pv.CADE %>%
  #filter(sample == 1) %>%
  ggplot(aes(y = lfm, x = RWD.excel, color = dry.weight, add = "reg.line")) + 
  geom_jitter() +
  ggtitle("6") +
  geom_vline(xintercept = tlprwd.r.topredict, linetype="dotted", 
             color = "blue", size=.5) +
  geom_hline(yintercept = lfm.predicted.r, linetype="dotted", 
             color = "blue", size=.5) +
  geom_smooth(method = "lm", size = 0.5, se = FALSE) +
  ylab("LFM") +
  xlab("Relative Water Deficit") + 
  ggtitle("CADE PV Curves") +
  geom_label(label="TLP: -2.66 Mpa",  x=18 ,y=80, label.padding = unit(0.1, "lines"), # Rectangle size around label
             label.size = 0.2, color = "black",fill="light blue") +
  stat_regline_equation(label.x = 1, label.y = 60)
rwdXlfm

fit <-lm(lfm~RWC, pv.CADE)
summary(fit)
tlprwc.value <- data.frame(RWC=c(79.80500402)) %>% pull()
tlprwc.excel <- data.frame(RWC=c(79.80500402))

rwcXlfm <- pv.CADE %>%
  #filter(sample == 6) %>%
  ggplot(aes(y = lfm, x = RWC.excel.allvalues, color = dry.weight, add = "reg.line")) + 
  geom_jitter() +
  ggtitle("6") +
  geom_vline(xintercept = tlprwc.r.value, linetype="dotted", 
             color = "blue", size=.5) +
  geom_hline(yintercept = lfm.predicted.r, linetype="dotted", 
             color = "blue", size=.5) +
  geom_smooth(method = "lm", size = 0.5, se = FALSE) +
  ylab("LFM") +
  xlab("Relative Water Content") + 
  ggtitle("CADE PV Curve/LFM Conversion") +
  geom_label(label="TLP: -2.66 Mpa",  x=82 ,y= 80, label.padding = unit(0.1, "lines"), # Rectangle size around label
             label.size = 0.2, color = "black",fill="light blue") +
  stat_regline_equation(label.x = 70, label.y = 90)
rwcXlfm
```



