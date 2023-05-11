#----------------
#TTI

```{r}
topmods <- MuMIn::dredge(lmer(tti ~ lfm_scaled:spp + mpa_scaled:spp + mpa_scaled + lfm_scaled + year_month + sample_wt_scaled + site + (1 | individual), data = mem_data_all_dredge, na.action = "na.fail", REML = F))

topmods
```


#------------------------------------

#TTI: 

## Can we remove some covariates? 

######LFM
```{r}
m0 <- lmer(tti ~ lfm_scaled*spp + site + year_month + sample_wt_scaled + (1 | individual), data = mem_data_all, REML = F)

anova(m0)

m1 <- lmer(tti ~lfm_scaled*spp  + year_month + sample_wt_scaled + (1 | individual), data = mem_data_all, REML = F)

#remove site

m2 <- lmer(tti ~ lfm_scaled*spp  + year_month  + (1 | individual), data = mem_data_all, REML = F)

summary(m2)

m3 <- lmer(tti ~ lfm_scaled*spp  + sample_wt_scaled + (1 | individual), data = mem_data_all, REML = F)

summary(m3)

m4 <- lmer(tti ~ lfm_scaled*spp  + (1 | individual), data = mem_data_all, REML = F)

summary(m4)

m5 <- lmer(tti ~ lfm_scaled + spp + (1 | individual), data = mem_data_all, REML = F)

summary(m5)

m6 <- lmer(tti ~ lfm_scaled*spp + mpa_scaled + sample_wt_scaled + (1 | individual), data = mem_data_all, REML = F)

m7  <- lmer(tti ~ mpa_scaled*spp + lfm_scaled + sample_wt_scaled + (1 | individual), data = mem_data_all, REML = F)

m8 <- lmer(tti ~ mpa_scaled*spp + lfm_scaled*spp + sample_wt_scaled + (1 | individual), data = mem_data_all, REML = F)

aictab(c(m1, m2, m3, m4, m5, m6, m7, m8, m0))

#m3 is the simplest within 2 AIC of the mode complex 'best'. If we want to have MPa also in the model to tell us something explicitly about physiology, we should include
```
Model m3 is the simplist and within 2 AIC, so use that. 

######MPa

```{r}
m0 <- lmer(tti ~ mpa_scaled*spp + site + year_month + sample_wt_scaled + (1 | individual), data = mem_data_all, REML = F)

summary(m0)

m1 <- lmer(tti ~ mpa_scaled*spp  + year_month + sample_wt_scaled + (1 | individual), data = mem_data_all, REML = F)

summary(m1)
#remove site

m2 <- lmer(tti ~ mpa_scaled*spp  + year_month + (1 | individual), data = mem_data_all, REML = F)

summary(m2)

m3 <- lmer(tti ~ mpa_scaled*spp  + sample_wt_scaled + (1 | individual), data = mem_data_all, REML = F)

summary(m3)

m4 <- lmer(tti ~ mpa_scaled:spp + (1 | individual), data = mem_data_all, REML = F)

summary(m4)

m5 <- lmer(tti ~ mpa_scaled + spp + (1 | individual), data = mem_data_all, REML = F)

summary(m5)

m6 <- lmer(tti ~ lfm_scaled*spp + mpa_scaled + sample_wt_scaled + (1 | individual), data = mem_data_all, REML = F)


m7  <- lmer(tti ~ mpa_scaled*spp + lfm_scaled + sample_wt_scaled + (1 | individual), data = mem_data_all, REML = F)

aictab(c(m1, m2, m3, m4, m5, #m6, m7, 
         m0))

#m6 and m7 are the best if you have both LFM and MPa
#with just MPa, m1, m6, and m3 are the best
```


###Models
```{r}
####b) TOP SPECIES MODELS: 
sppmod <- lmer(tti ~ spp + sample_wt_scaled + (1 | individual), data = mem_data_all, REML = F)
summary(sppmod)

m1 <- lmer(tti ~ lfm_scaled*spp + sample_wt_scaled + (1 | individual), data = mem_data_all, REML = F)
summary(m1)

m2 <- lmer(tti ~ mpa_scaled*spp + sample_wt_scaled + (1 | individual), data = mem_data_all, REML = F)

m1.5 <- lmer(tti ~ lfm_scaled*spp + mpa_scaled + sample_wt_scaled + (1 | individual), data = mem_data_all, REML = F)

m2.5 <- lmer(tti ~ mpa_scaled*spp + lfm_scaled + sample_wt_scaled + (1 | individual), data = mem_data_all, REML = F)

performance::check_collinearity(m2.5)

aictab(c(m1, m2, m1.5, m2.5, sppmod))
###
```
LFM is the better predictor in the species model, either with MPa or without MPa. 

###temp_change 

```{r}
####b) TOP SPECIES MODELS: 
sppmod <- lmer(temp_change ~ spp + sample_wt_scaled + (1 | individual), data = mem_data_all, REML = F)
summary(sppmod)

m1 <- lmer(temp_change ~ lfm_scaled*spp + sample_wt_scaled + (1 | individual), data = mem_data_all, REML = F)
summary(m1)

m2 <- lmer(temp_change ~ mpa_scaled*spp + sample_wt_scaled + (1 | individual), data = mem_data_all, REML = F)

m1.5 <- lmer(temp_change ~ lfm_scaled*spp + mpa_scaled + sample_wt_scaled + (1 | individual), data = mem_data_all, REML = F)

m2.5 <- lmer(temp_change ~ mpa_scaled*spp + lfm_scaled + sample_wt_scaled + (1 | individual), data = mem_data_all, REML = F)

m3 <- lmer(temp_change ~ mpa_scaled*spp + lfm_scaled*spp + sample_wt_scaled + (1 | individual), data = mem_data_all, REML = F)

aictab(c(m1, m2, m1.5, m2.5, sppmod, m3))
###

summary(m1.5)
```

###FD 

```{r}
####b) TOP SPECIES MODELS: 
sppmod <- lmer(fd ~ spp + sample_wt_scaled + (1 | individual), data = mem_data_all, REML = F)
summary(sppmod)

m1 <- lmer(fd ~ lfm_scaled*spp + sample_wt_scaled + (1 | individual), data = mem_data_all, REML = F)
summary(m1)

m2 <- lmer(fd ~ mpa_scaled*spp + sample_wt_scaled + (1 | individual), data = mem_data_all, REML = F)

m1.5 <- lmer(fd ~ lfm_scaled*spp + mpa_scaled + sample_wt_scaled + (1 | individual), data = mem_data_all, REML = F)

m2.5 <- lmer(fd ~ mpa_scaled*spp + lfm_scaled + sample_wt_scaled + (1 | individual), data = mem_data_all, REML = F)

m3 <- lmer(fd ~ mpa_scaled*spp + lfm_scaled*spp + sample_wt_scaled + (1 | individual), data = mem_data_all, REML = F)

aictab(c(m1, m2, m1.5, m2.5, sppmod, m3))
###
```

###fh 

```{r}
####b) TOP SPECIES MODELS: 
sppmod <- lmer(fh ~ spp + sample_wt_scaled + (1 | individual), data = mem_data_all, REML = F)
summary(sppmod)

m1 <- lmer(fh ~ lfm_scaled*spp + sample_wt_scaled + (1 | individual), data = mem_data_all, REML = F)
summary(m1)

m2 <- lmer(fh ~ mpa_scaled*spp + sample_wt_scaled + (1 | individual), data = mem_data_all, REML = F)

m1.5 <- lmer(fh ~ lfm_scaled*spp + mpa_scaled + sample_wt_scaled + (1 | individual), data = mem_data_all, REML = F)

m2.5 <- lmer(fh ~ mpa_scaled*spp + lfm_scaled + sample_wt_scaled + (1 | individual), data = mem_data_all, REML = F)

m3 <- lmer(fh ~ mpa_scaled*spp + lfm_scaled*spp + sample_wt_scaled + (1 | individual), data = mem_data_all, REML = F)

aictab(c(m1, m2, m1.5, m2.5, sppmod, m3))
###
```
###gD

```{r}
####b) TOP SPECIES MODELS: 
m1 <- lmer(gd ~ lfm_scaled*spp + sample_wt_scaled + (1 | individual), data = mem_data_all, REML = F)
summary(m1)

m2 <- lmer(gd ~ mpa_scaled*spp + sample_wt_scaled + (1 | individual), data = mem_data_all, REML = F)

m1.5 <- lmer(gd ~ lfm_scaled*spp + mpa_scaled + sample_wt_scaled + (1 | individual), data = mem_data_all, REML = F)

m2.5 <- lmer(gd ~ mpa_scaled*spp + lfm_scaled + sample_wt_scaled + (1 | individual), data = mem_data_all, REML = F)

m3 <- lmer(gd ~ mpa_scaled*spp + lfm_scaled*spp + sample_wt_scaled + (1 | individual), data = mem_data_all, REML = F)

sppmod <- lmer(gd ~ spp + sample_wt_scaled + (1 | individual), data = mem_data_all, REML = F)
summary(sppmod)

aictab(c(m1, m2, m1.5, m2.5 #sppmod, m3
))
###

summary(m3)
```

```{r}
####c) Functional group models:

m3 <- lmer(tti ~ lfm_scaled*fun_gr + sample_wt_scaled + (1 | individual), data = mem_data_all, REML = F)
summary(m3)

m4 <- lmer(tti ~ mpa_scaled*fun_gr + sample_wt_scaled +  (1 | individual), data = mem_data_all, REML = F)
summary(m4)

m5 <- lmer(tti ~ lfm_scaled*fun_gr + mpa_scaled + sample_wt_scaled +  (1 | individual), data = mem_data_all, REML = F)
summary(m5)

m6 <- lmer(tti ~ lfm_scaled + fun_gr*mpa_scaled + sample_wt_scaled +  (1 | individual), data = mem_data_all, REML = F)
summary(m6)

aictab(c(m1, m2, m3, m4, m5, m6, m1.5, m2.5))

m1
```

Based on AIC, m1 is the most parsimonious by far. 

```{r}
tab_model(m1, m2, m3, m5, m6,
          show.reflvl = TRUE, 
          digits = 3, 
          show.aic = TRUE, 
          show.ci = FALSE,
          show.icc = FALSE, 
          string.p = "P-Value", 
          p.style = "stars")
```

```{r}
sjPlot::plot_model(m1.5)
```

#-------------------------

#FIRST ATTEMPT:

```{r}
m3_df <- broom.mixed::tidy(m3) %>% mutate(model = "LFM * Species", mod = "m3")
m2_df <- broom.mixed::tidy(m2) %>%  mutate(model = "MPa * Species", mod = "m2")
m1.5df <- broom.mixed::tidy(m1.5) %>%  mutate(model = "MPa + LFM + Species", mod = "m1.5")


mods_spp_df <- bind_rows(m2_df, m3_df, m1.5df)

mods_spp_df
```

Do all of these models agree on their results?
  
  ```{r}
mods_df %>% 
  # filter(term %in% c("mpa_scaled", "lfm_scaled", "spparpa", "sppcade", "sppceco", "spppije", "sppquke")) %>% 
  ggplot(aes(x = term, y = estimate, color = model)) +
  geom_jitter()
```

Yeah, pretty much. 

####2.2 Comparing F.group models:

Models with Functional Group include a models with Mpa x F.Group and LFM x F.Group (m4), MPa x F.Group (m5), LFM x F.Group (m6). Of these, the most parsemoneous is m4 by quite a bit (AIC > 10). This is the model we can use to compare between functional groups. 

```{r}
aictab(c(m1, m2, m3, m4, m5, m6, m7, m8, m9, m1.5))

m1

aictab(c(m1, m4))
```


```{r}
m6_df <- broom.mixed::tidy(m6) %>% mutate(model = "LFM * F.Group", mod = "m6")
m5_df <- broom.mixed::tidy(m5) %>%  mutate(model = "MPa * F.Group", mod = "m5")
m4_df <- broom.mixed::tidy(m4) %>%  mutate(model = "MPa * LFM * F.Group", mod = "m4")


mods_tti_df <- bind_rows(mods_spp_df, m4_df, m5_df, m6_df) %>% 
  mutate(sig = case_when(
    p.value > 0.05 ~ "No", 
    TRUE ~ "Yes"
  ))

mods_tti_df
```

Do all of these models agree on their results?
  
  ```{r}
mods_tti_df %>% 
  ggplot(aes(x = term, y = estimate)) +
  geom_jitter() +
  facet_wrap(~model)
```

Yeah, pretty much. 

So,our best models are as follows: 
  ```{r}
top_mods <- mods_tti_df %>% 
  filter(mod %in% c("m1.5", "m2", "m3", "m4"))

top_mods %>% 
  ggplot(aes(x = term, y = estimate, color = sig)) +
  geom_point() +
  facet_wrap(~model) +
  theme(axis.text = element_text(angle = 90))
```
####2.3 Split by F.group, then do spp:

Since functional groups are different...

```{r}
m4
summary(m4)
```

...we can use that to split the dataset by functional group: 
  
  ```{r}
gymno_df <- mem_data_all %>% 
  filter(fun_gr %in% c("Gymnosperm"))

angio_df <- mem_data_all %>% 
  filter(fun_gr %in% c("Angiosperm"))
```

Now, compare species within each functional group: 
  
  ####Angios: 
  
  How many parameters can we have? 
  
  ```{r}
angio_inds <- angio_df %>% 
  group_by(individual) %>% 
  summarise() %>% 
  nrow

angio_inds/10

#Ideally not more than 6...


#m0 <- lmer(tti ~ mpa_scaled*spp + lfm_scaled*spp + site + year_month + sample_wt_scaled + (1 | individual), data = angio_df, REML = F) #too many parameters

m1 <- lmer(tti ~ lfm_scaled*spp + mpa_scaled*spp + (1 | individual), data = angio_df, REML = F)

m2 <- lmer(tti ~ mpa_scaled*spp + (1 | individual), data = angio_df, REML = F)

m3 <- lmer(tti ~ lfm_scaled*spp + (1 | individual), data = angio_df, REML = F)

m4 <- lmer(tti ~ lfm_scaled + mpa_scaled + spp + (1 | individual), data = angio_df, REML = F)

aictab(c(m1, m2, m3, m4))


#For angiosperms, we have too many parameters if we use m0, so kick that one out. We can use the others, and either decide to model MPa and LFM separately (K = 8 for each) or have no interactions (K = 7). Since we're fairly confident that there ARE interactions, we'll likely end up using the model with interactions and a slightly higher K, but that's maybe oky? 

m3_df <- broom.mixed::tidy(m3) %>% mutate(model = "LFM * Species",
                                          mod = "m3",
                                          fun_gr = "Angiosperm",
                                          flam = "Time to Ignition")
m2_df <- broom.mixed::tidy(m2) %>%  mutate(model = "MPa * Species",
                                           mod = "m2",
                                           fun_gr = "Angiosperm",
                                           flam = "Time to Ignition")
m4_df <- broom.mixed::tidy(m1.5) %>%  mutate(model = "MPa + LFM + Species",
                                             mod = "m4",
                                             fun_gr = "Angiosperm",
                                             flam = "Time to Ignition")


angio_spp_df <- bind_rows(m2_df, m3_df, m4_df)

angio_spp_df
```

####Gymnos: 

How many parameters can we have? 
  
  ```{r}
gymno_inds <- gymno_df %>% 
  group_by(individual) %>% 
  summarise() %>% 
  nrow

gymno_inds/10

#Ideally not more than 6...


#m0 <- lmer(tti ~ mpa_scaled*spp + lfm_scaled*spp + site + year_month + sample_wt_scaled + (1 | individual), data = gymno_df, REML = F) #too many parameters

m1 <- lmer(tti ~ lfm_scaled*spp + mpa_scaled*spp + (1 | individual), data = gymno_df, REML = F)

m2 <- lmer(tti ~ mpa_scaled*spp + (1 | individual), data = gymno_df, REML = F)

m3 <- lmer(tti ~ lfm_scaled*spp + (1 | individual), data = gymno_df, REML = F)

m4 <- lmer(tti ~ lfm_scaled + mpa_scaled + spp + (1 | individual), data = gymno_df, REML = F)

m5 <- lmer(tti ~ lfm_scaled*spp + mpa_scaled + (1 | individual), data = gymno_df, REML = F)

m6 <- lmer(tti ~ lfm_scaled + spp*mpa_scaled + (1 | individual), data = gymno_df, REML = F)

aictab(c(m1, m2, m3, m4, m5, m6))


#For gymnosperms, we have too many parameters if we use m0, so kick that one out. We can use the others, and either decide to model MPa and LFM separately (K = 8 for each) or have no interactions (K = 7). Since we're fairly confident that there ARE interactions, we'll likely end up using the model with interactions and a slightly higher K, but that's maybe oky? 

m3_df <- broom.mixed::tidy(m3) %>% mutate(model = "LFM * Species",
                                          mod = "m3",
                                          fun_gr = "Gymnosperm",
                                          flam = "Time to Ignition")
m2_df <- broom.mixed::tidy(m2) %>%  mutate(model = "MPa * Species",
                                           mod = "m2",
                                           fun_gr = "Gymnosperm",
                                           flam = "Time to Ignition")
m4_df <- broom.mixed::tidy(m1.5) %>%  mutate(model = "MPa + LFM + Species",
                                             mod = "m4",
                                             fun_gr = "Gymnosperm",
                                             flam = "Time to Ignition")

gymno_spp_df <- bind_rows(m2_df, m3_df, m4_df)

gymno_spp_df
```

####Combine:

```{r}
spp_est_tti_df <- bind_rows(gymno_spp_df, angio_spp_df)
```

#FH: 

###Models:

```{r}
####e) Species models:

m1 <- lmer(fh ~ lfm_scaled*spp + mpa_scaled*spp + (1 | individual), data = mem_data_all, REML = F)

m1.5 <- lmer(fh ~ lfm_scaled + mpa_scaled + spp + (1 | individual), data = mem_data_all, REML = F)

m2 <- lmer(fh ~ mpa_scaled*spp + (1 | individual), data = mem_data_all, REML = F)

m3 <- lmer(fh ~ lfm_scaled*spp + (1 | individual), data = mem_data_all, REML = F)



###) Functional group models:


m4 <- lmer(fh ~ lfm_scaled*fun_gr + mpa_scaled*fun_gr + (1 | individual), data = mem_data_all, REML = F)

m5 <- lmer(fh ~ mpa_scaled*fun_gr + (1 | individual), data = mem_data_all, REML = F)

m6 <- lmer(fh ~ lfm_scaled*fun_gr + (1 | individual), data = mem_data_all, REML = F)


#No species: 


m7 <- lmer(fh ~ lfm_scaled + (1 | individual), data = mem_data_all, REML = F)

m8 <- lmer(fh ~ mpa_scaled + (1 | individual), data = mem_data_all, REML = F)
```

Compare all of the models: 
  ```{r}
#Even with a very loose threshold for datapoints/parameters, we still should maximally only have 12: 
nr_inds_all/10
```

```{r}
aictab(c(m1, m2, m3, m4, m5, m6, m7, m8, m1.5))
```

Models that are not overfit and might work are m3 and m2 (MPa x Spp, or LFM x Spp), but better are m1.5 (MPa + Spp + LFM), or else m4 (Mpa x F Group + LFM x F Group), which we can then split into spp models like last time. 


#####2.4 Split by F.group, then do spp:

Models with Functional Group include a models with Mpa x F.Group and LFM x F.Group (m4), MPa x F.Group (m5), LFM x F.Group (m6). Of these, the most parsemoneous is m4 by quite a bit (delta AIC > 10). This is the model we can use to compare between functional groups. 

####Angios: 

How many parameters can we have? 
  
  ```{r}
angio_inds <- angio_df %>% 
  group_by(individual) %>% 
  summarise() %>% 
  nrow

angio_inds/10

#Ideally not more than 6...


#m0 <- lmer(fh ~ mpa_scaled*spp + lfm_scaled*spp + site + year_month + sample_wt_scaled + (1 | individual), data = angio_df, REML = F) #too many parameters

m1 <- lmer(fh ~ lfm_scaled*spp + mpa_scaled*spp + (1 | individual), data = angio_df, REML = F)

m2 <- lmer(fh ~ mpa_scaled*spp + (1 | individual), data = angio_df, REML = F)

m3 <- lmer(fh ~ lfm_scaled*spp + (1 | individual), data = angio_df, REML = F)

m4 <- lmer(fh ~ lfm_scaled + mpa_scaled + spp + (1 | individual), data = angio_df, REML = F)

aictab(c(m1, m2, m3, m4))


#For angiosperms, we have too many parameters if we use m0, so kick that one out. We can use the others, and either decide to model MPa and LFM separately (K = 8 for each) or have no interactions (K = 7). Since we're fairly confident that there ARE interactions, we'll likely end up using the model with interactions and a slightly higher K, but that's maybe oky? 

m3_df <- broom.mixed::tidy(m3) %>% mutate(model = "LFM * Species",
                                          mod = "m3",
                                          fun_gr = "Angiosperm",
                                          flam = "Flame Height")
m2_df <- broom.mixed::tidy(m2) %>%  mutate(model = "MPa * Species",
                                           mod = "m2",
                                           fun_gr = "Angiosperm",
                                           flam = "Flame Height")
m4_df <- broom.mixed::tidy(m1.5) %>%  mutate(model = "MPa + LFM + Species",
                                             mod = "m4",
                                             fun_gr = "Angiosperm", 
                                             flam = "Flame Height")


angio_spp_df <- bind_rows(m2_df, m3_df, m4_df)

angio_spp_df
```

####Gymnos: 

How many parameters can we have? 
  
  ```{r}
gymno_inds <- gymno_df %>% 
  group_by(individual) %>% 
  summarise() %>% 
  nrow

gymno_inds/10

#Ideally not more than 6...


#m0 <- lmer(fh ~ mpa_scaled*spp + lfm_scaled*spp + site + year_month + sample_wt_scaled + (1 | individual), data = gymno_df, REML = F) #too many parameters

m1 <- lmer(fh ~ lfm_scaled*spp + mpa_scaled*spp + (1 | individual), data = gymno_df, REML = F)

m2 <- lmer(fh ~ mpa_scaled*spp + (1 | individual), data = gymno_df, REML = F)

m3 <- lmer(fh ~ lfm_scaled*spp + (1 | individual), data = gymno_df, REML = F)

m4 <- lmer(fh ~ lfm_scaled + mpa_scaled + spp + (1 | individual), data = gymno_df, REML = F)

aictab(c(m1, m2, m3, m4))


#For gymnosperms, we have too many parameters if we use m0, so kick that one out. We can use the others, and either decide to model MPa and LFM separately (K = 8 for each) or have no interactions (K = 7). Since we're fairly confident that there ARE interactions, we'll likely end up using the model with interactions and a slightly higher K, but that's maybe oky? 

m3_df <- broom.mixed::tidy(m3) %>% mutate(
  model = "LFM * Species",
  mod = "m3",
  fun_gr = "Gymnosperm",
  flam = "Flame Height"
)
m2_df <- broom.mixed::tidy(m2) %>%  mutate(
  model = "MPa * Species",
  mod = "m2",
  fun_gr = "Gymnosperm",
  flam = "Flame Height"
)
m4_df <- broom.mixed::tidy(m1.5) %>%  mutate(
  model = "MPa + LFM + Species",
  mod = "m4",
  fun_gr = "Gymnosperm",
  flam = "Flame Height"
)

gymno_spp_df <- bind_rows(m2_df, m3_df, m4_df)

gymno_spp_df
```

####Combine:

```{r}
spp_est_fh_df <- bind_rows(gymno_spp_df, angio_spp_df)
```



#GD: 

####Models:

```{r}
#### Species models: 

m1 <- lmer(gd ~ lfm_scaled*spp + mpa_scaled*spp + (1 | individual), data = mem_data_all, REML = F)

m1.5 <- lmer(gd ~ lfm_scaled + mpa_scaled + spp + (1 | individual), data = mem_data_all, REML = F)

m2 <- lmer(gd ~ mpa_scaled*spp + (1 | individual), data = mem_data_all, REML = F)

m3 <- lmer(gd ~ lfm_scaled*spp + (1 | individual), data = mem_data_all, REML = F)

#### Functional group models:


m4 <- lmer(gd ~ lfm_scaled*fun_gr + mpa_scaled*fun_gr + (1 | individual), data = mem_data_all, REML = F)

m5 <- lmer(gd ~ mpa_scaled*fun_gr + (1 | individual), data = mem_data_all, REML = F)

m6 <- lmer(gd ~ lfm_scaled*fun_gr + (1 | individual), data = mem_data_all, REML = F)


#No species: 


m7 <- lmer(gd ~ lfm_scaled + (1 | individual), data = mem_data_all, REML = F)

m8 <- lmer(gd ~ mpa_scaled + (1 | individual), data = mem_data_all, REML = F)

aictab(c(m1, m2, m3, m4, m5, m6, m7, m8, m1.5))
```

Models that are not overfit and might work are m3 and m2 (MPa x Spp, or LFM x Spp), but better are m1.5 (MPa + Spp + LFM), or else m4 (Mpa x F Group + LFM x F Group), which we can then split into spp models like last times. 


####Split by F.group, then do spp:

Models with Functional Group include a models with Mpa x F.Group and LFM x F.Group (m4), MPa x F.Group (m5), LFM x F.Group (m6). Of these, the most parsemoneous is m4 by quite a bit (delta AIC > 10). This is the model we can use to compare between functional groups. 

####Angios: 

How many parameters can we have? 
  
  ```{r}
angio_inds <- angio_df %>% 
  group_by(individual) %>% 
  summarise() %>% 
  nrow

angio_inds/10

#Ideally not more than 6...


#m0 <- lmer(gd ~ mpa_scaled*spp + lfm_scaled*spp + site + year_month + sample_wt_scaled + (1 | individual), data = angio_df, REML = F) #too many parameters

m1 <- lmer(gd ~ lfm_scaled*spp + mpa_scaled*spp + (1 | individual), data = angio_df, REML = F)

m2 <- lmer(gd ~ mpa_scaled*spp + (1 | individual), data = angio_df, REML = F)

m3 <- lmer(gd ~ lfm_scaled*spp + (1 | individual), data = angio_df, REML = F)

m4 <- lmer(gd ~ lfm_scaled + mpa_scaled + spp + (1 | individual), data = angio_df, REML = F)

aictab(c(m1, m2, m3, m4))


#For angiosperms, we have too many parameters if we use m0, so kick that one out. We can use the others, and either decide to model MPa and LFM separately (K = 8 for each) or have no interactions (K = 7). Since we're fairly confident that there ARE interactions, we'll likely end up using the model with interactions and a slightly higher K, but that's maybe oky? 

m3_df <- broom.mixed::tidy(m3) %>% mutate(model = "LFM * Species",
                                          mod = "m3",
                                          fun_gr = "Angiosperm",
                                          flam = "Glow Duration")
m2_df <- broom.mixed::tidy(m2) %>%  mutate(model = "MPa * Species",
                                           mod = "m2",
                                           fun_gr = "Angiosperm",
                                           flam = "Glow Duration")
m4_df <- broom.mixed::tidy(m1.5) %>%  mutate(model = "MPa + LFM + Species",
                                             mod = "m4",
                                             fun_gr = "Angiosperm", 
                                             flam = "Glow Duration")


angio_spp_df <- bind_rows(m2_df, m3_df, m4_df)

angio_spp_df
```

####Gymnos: 

How many parameters can we have? 
  
  ```{r}
gymno_inds <- gymno_df %>% 
  group_by(individual) %>% 
  summarise() %>% 
  nrow

gymno_inds/10

#Ideally not more than 6...


#m0 <- lmer(gd ~ mpa_scaled*spp + lfm_scaled*spp + site + year_month + sample_wt_scaled + (1 | individual), data = gymno_df, REML = F) #too many parameters

m1 <- lmer(gd ~ lfm_scaled*spp + mpa_scaled*spp + (1 | individual), data = gymno_df, REML = F)

m2 <- lmer(gd ~ mpa_scaled*spp + (1 | individual), data = gymno_df, REML = F)

m3 <- lmer(gd ~ lfm_scaled*spp + (1 | individual), data = gymno_df, REML = F)

m4 <- lmer(gd ~ lfm_scaled + mpa_scaled + spp + (1 | individual), data = gymno_df, REML = F)

aictab(c(m1, m2, m3, m4))


#For gymnosperms, we have too many parameters if we use m0, so kick that one out. We can use the others, and either decide to model MPa and LFM separately (K = 8 for each) or have no interactions (K = 7). Since we're fairly confident that there ARE interactions, we'll likely end up using the model with interactions and a slightly higher K, but that's maybe oky? 

m3_df <- broom.mixed::tidy(m3) %>% mutate(
  model = "LFM * Species",
  mod = "m3",
  fun_gr = "Gymnosperm",
  flam = "Glow Duration"
)
m2_df <- broom.mixed::tidy(m2) %>%  mutate(
  model = "MPa * Species",
  mod = "m2",
  fun_gr = "Gymnosperm",
  flam = "Glow Duration"
)
m4_df <- broom.mixed::tidy(m1.5) %>%  mutate(
  model = "MPa + LFM + Species",
  mod = "m4",
  fun_gr = "Gymnosperm",
  flam = "Glow Duration"
)

gymno_spp_df <- bind_rows(m2_df, m3_df, m4_df)

gymno_spp_df
```

####Combine:

```{r}
spp_est_gd_df <- bind_rows(gymno_spp_df, angio_spp_df)
```

#All together: 

```{r}
spp_est_df <- bind_rows(spp_est_tti_df, spp_est_fh_df, spp_est_gd_df)
```

#CONCLUSION: 

The 'best' models, that have the lowest AIC and are ~ not overfit ~ are: 
  
  1) Split dataset by f.group
2) Have MPa x Spp and LFM x Spp as separate models: 
  
  ```{r}
spp_est_df

spp_est_df %>% 
  filter(
    mod %in% c("m2", "m3"),
    flam %in% c('Time to Ignition'),
    term %in% c(
      'lfm_scaled:sppquke',
      'lfm_scaled:spppije',
      'lfm_scaled',
      'lfm_scaled:sppceco',
      'lfm_scaled:sppcade',
      'mpa_scaled:sppquke',
      'mpa_scaled:spppije',
      'mpa_scaled',
      'mpa_scaled:sppceco',
      'mpa_scaled:sppcade'
    )
  ) %>% 
  ggplot(aes(y = estimate, x = term)) +
  geom_point() +
  facet_wrap(~fun_gr*mod, scales = "free_x")+
  scale_shape_manual(values = c(10, 16)) +
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
        #plot.margin = unit(margins.vector, 'cm'),
        legend.position = 'none')
```

## Functional Groups

####TTI
```{r}
mem_data_all_r <- mem_data_all %>% drop_na(mpa_scaled, lfm_scaled, sample_wt_scaled, fh, gd)
mem_data_all_r$Species <- factor(mem_data_all_r$Species, levels = c('Ab. concolor', 'Pi. jeffreyi', 'Ca. decurrens', 'Ar. patula', 'Qu. kelloggii'))

mem_data_all_r <- mem_data_all_r %>%
  mutate(F.Group = case_when(
    spp == "arpa" ~ "Angiosperm", 
    spp == "abco" ~ "Gymnosperm",
    spp == "cade" ~ "Gymnosperm",
    spp == "ceco" ~ "Angiosperm",
    spp == "pije" ~ "Gymnosperm",
    spp == "quke" ~ "Angiosperm"
  )) 

tti_mod <- lmer(fh ~ lfm_scaled*F.Group + mpa_scaled*F.Group + (1 | individual), data = mem_data_all_r, REML = T)

summary(tti_mod)
#Remef:

r_tti_mpa <- remef(tti_mod, fix = c("lfm_scaled"), ran = list(individual = c("(Intercept)"))) # Using Remef for plots with MPa

r_tti_lfm <- remef(tti_mod, fix = c("mpa_scaled"), ran = list(individual = c("(Intercept)"))) # Using Remef for plots with LFM

mem_data_all_r$r_tti_mpa <- r_tti_mpa
mem_data_all_r$r_tti_lfm <- r_tti_lfm

#Significance (ignore this?)

mem_data_all_r <- mem_data_all_r %>% 
  mutate(F.tti.lfm.sig = case_when(F.Group == "Angiosperm" ~ "Yes", 
                                   F.Group == "Gymnosperm" ~ "Yes")) %>% 
  mutate(F.tti.mpa.sig = case_when(F.Group == "Angiosperm" ~ "Yes", 
                                   F.Group == "Gymnosperm" ~ "Yes"))
```

Visualizations:
  
  Significance is saying "significance of the the interaction term between the 
```{r}
tti_plot_mpa_r <- mem_data_all_r %>% 
  ggplot(aes(y = r_tti_mpa, 
             x = mpa_scaled, 
             group = F.Group)) +
  geom_point(alpha= .4, aes(color = F.Group))+
  geom_smooth(method = "lm", se = F, aes(color = F.Group, lty = F.tti.mpa.sig), alpha = .75) + 
  scale_color_manual(values = c('steelblue3', 'darkgreen'))+
  theme(legend.position = "none",                                   
        axis.text = element_text(size = 14),
        axis.title = element_text(size = 22, face = 'bold'))+
  labs(x = "", 
       y = "Time to Ignition") +
  annotate(geom = "text", x = -1.8, y = 235, label = 'a', fontface = 'bold', size = 10)
tti_plot_mpa_r

# For MAIN figure:
tti_plot_lfm_r <- mem_data_all_r %>%
  ggplot(aes(y = r_tti_lfm, 
             x = lfm_scaled, 
             group = F.Group)) +
  geom_point(alpha= .4, aes(color = F.Group))+
  geom_smooth(method = "lm", se = F, aes(color = F.Group, lty = F.tti.lfm.sig), alpha = .75, lty = 1) + 
  scale_color_manual(values = c('steelblue3', 'darkgreen')) + 
  theme(legend.position = "none",
                       axis.text.y = element_text(size = 13),
                       axis.title = element_text(size = 16, face = 'bold'),
                       axis.text.x = element_blank(), axis.ticks.x = element_blank()) +
  labs(x = "", 
       y = "Time to Ignition (s)") +
  annotate(geom = "text", x = -2.6, y = 192.5, label = 'b', fontface = 'bold', size = 10)
tti_plot_lfm_r
```

BUT what if we don't want to remove the effect of LFM or MPa, and see them both together?

####FH
```{r}
mem_data_all_r <- mem_data_all %>% drop_na(mpa_scaled, lfm_scaled, sample_wt_scaled, fh, gd)
mem_data_all_r$Species <- factor(mem_data_all_r$Species, levels = c('Ab. concolor', 'Pi. jeffreyi', 'Ca. decurrens', 'Ar. patula', 'Qu. kelloggii'))

mem_data_all_r <- mem_data_all_r %>%
  mutate(F.Group = case_when(
    spp == "arpa" ~ "Angiosperm", 
    spp == "abco" ~ "Gymnosperm",
    spp == "cade" ~ "Gymnosperm",
    spp == "ceco" ~ "Angiosperm",
    spp == "pije" ~ "Gymnosperm",
    spp == "quke" ~ "Angiosperm"
  )) 

fh_mod <- lmer(fh ~ lfm_scaled*F.Group + mpa_scaled*F.Group + (1 | individual), data = mem_data_all_r, REML = T)

summary(fh_mod)
#Remef:

r_fh_mpa <- remef(fh_mod, fix = c("lfm_scaled"), ran = list(individual = c("(Intercept)"))) # Using Remef for plots with MPa

r_fh_lfm <- remef(fh_mod, fix = c("mpa_scaled"), ran = list(individual = c("(Intercept)"))) # Using Remef for plots with LFM

mem_data_all_r$r_fh_mpa <- r_fh_mpa
mem_data_all_r$r_fh_lfm <- r_fh_lfm

#Significance (ignore this?)

mem_data_all_r <- mem_data_all_r %>% 
  mutate(F.fh.lfm.sig = case_when(F.Group == "Angiosperm" ~ "Yes", 
                               F.Group == "Gymnosperm" ~ "Yes")) %>% 
  mutate(F.fh.mpa.sig = case_when(F.Group == "Angiosperm" ~ "Yes", 
                               F.Group == "Gymnosperm" ~ "Yes"))

#Visualizations: 

fh_plot_r <- mem_data_all_r %>% 
  ggplot(aes(y = r_fh_mpa, 
             x = mpa_scaled, 
             group = F.Group)) +
  geom_point(alpha= .4, aes(color = F.Group))+
  geom_smooth(method = "lm", se = F, aes(color = F.Group, lty = F.fh.mpa.sig), alpha = .75) +
  scale_color_manual(values = c('steelblue3', 'darkgreen'))+
  theme(legend.position = "none",
        axis.text = element_text(size = 14),
        axis.title = element_text(size = 22, face = 'bold'))+
  labs(x = "", 
       y = "Flame Height") +
  annotate(geom = "text", x = -1.8, y = 53, label = 'b', fontface = 'bold', size = 10)
fh_plot_r

# for MAIN figure
fh_plot_lfm_r <- mem_data_all_r %>% 
  ggplot(aes(y = r_fh_lfm, 
             x = lfm_scaled, 
             group = F.Group)) +
  geom_point(alpha= .4, aes(color = F.Group))+
  geom_smooth(method = "lm", se = F, aes(color = F.Group, lty = F.fh.lfm.sig), alpha = .75) +
  scale_color_manual(values = c('steelblue3', 'darkgreen')) + 
  scale_linetype_manual(values = c(3, 1)) +
  theme(legend.position = "none",
                       axis.text = element_text(size = 13),
                       axis.title.y = element_text(size = 16, face = 'bold', 
                                                   margin = margin(r = 10)),
                       axis.text.x = element_blank(), axis.ticks.x = element_blank())+
  labs(x = "", 
       y = "Flame Height (cm)") +
  annotate(geom = "text", x = -2.6, y = 54, label = 'c', fontface = 'bold', size = 10)
fh_plot_lfm_r
```

####GD: 

```{r}
mem_data_all_r <- mem_data_all %>% drop_na(mpa_scaled, lfm_scaled, sample_wt_scaled, gd, gd)
mem_data_all_r$Species <- factor(mem_data_all_r$Species, levels = c('Ab. concolor', 'Pi. jeffreyi', 'Ca. decurrens', 'Ar. patula', 'Qu. kelloggii'))

mem_data_all_r <- mem_data_all_r %>%
  mutate(F.Group = case_when(
    spp == "arpa" ~ "Angiosperm", 
    spp == "abco" ~ "Gymnosperm",
    spp == "cade" ~ "Gymnosperm",
    spp == "ceco" ~ "Angiosperm",
    spp == "pije" ~ "Gymnosperm",
    spp == "quke" ~ "Angiosperm"
  )) 

gd_mod <- lmer(gd ~ lfm_scaled*F.Group + mpa_scaled*F.Group + (1 | individual), data = mem_data_all_r, REML = T)

summary(gd_mod)
#Remef:

#remove effect of LFM
r_gd_mpa <- remef(gd_mod, fix = c("lfm_scaled"), ran = list(individual = c("(Intercept)"))) # Using Remef for plots with MPa

#Remove effect of MPA:
r_gd_lfm <- remef(gd_mod, fix = c("mpa_scaled"), ran = list(individual = c("(Intercept)"))) # Using Remef for plots with LFM

mem_data_all_r$r_gd_mpa <- r_gd_mpa
mem_data_all_r$r_gd_lfm <- r_gd_lfm

#Significance (ignore this?)

mem_data_all_r <- mem_data_all_r %>% 
  mutate(F.gd.lfm.sig = case_when(F.Group == "Angiosperm" ~ "No", 
                               F.Group == "Gymnosperm" ~ "No")) %>% 
  mutate(F.gd.mpa.sig = case_when(F.Group == "Angiosperm" ~ "No", 
                               F.Group == "Gymnosperm" ~ "No"))
```

```{r}
#REMEF
gd_plot_r <- mem_data_all_r %>% 
  ggplot(aes(y = r_gd_mpa, 
             x = mpa_scaled, 
             group = F.Group)) +
  geom_point(alpha= .4, aes(color = F.Group))+
  geom_smooth(method = "lm", se = F, aes(color = F.Group, lty = F.gd.mpa.sig), alpha = .75) +
  scale_color_manual(values = c('steelblue3', 'darkgreen'))+
  theme(legend.position = "none",
        axis.text = element_text(size = 14),
        axis.title = element_text(size = 22, face = 'bold'))+
  labs(x = "", 
       y = "Glow Duration") +
  annotate(geom = "text", x = -1.8, y = 430, label = 'c', fontface = 'bold', size = 10)
gd_plot_r

# for *MAIN* figure:
gd_plot_lfm_r <- mem_data_all_r %>% 
  ggplot(aes(y = r_gd_lfm, 
             x = lfm_scaled, 
             group = F.Group)) +
  geom_point(alpha= .4, aes(color = F.Group))+
  geom_smooth(method = "lm", se = F, aes(color = F.Group, lty = F.gd.lfm.sig),
              alpha = .75, lty = 3) +
  theme(legend.position = "none",
                       axis.text = element_text(size = 13),
                       axis.title = element_text(size = 16, face = 'bold'))+
  scale_color_manual(values = c('steelblue3', 'darkgreen')) +
  labs(x = "LFM", 
       y = "Glow Duration (s)")
  annotate(geom = "text", x = -2.6, y = 400, label = 'g', fontface = 'bold', size = 10)
gd_plot_lfm_r
```


