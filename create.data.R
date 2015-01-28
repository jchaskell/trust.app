#This file creates the data for the shiny app

#packages
library(plyr)
library(dplyr)
library(ggvis)

#read in WVS data
setwd("C:/Dropbox/Projects/Dissertation/WVS/trust.app")
wvs <- read.csv(file = "wvs_20141208.csv", stringsAsFactors = FALSE)

list <- read.csv(file = "WVSw6_list.csv", stringsAsFactors = FALSE)
wvs <- merge(wvs, list, by = c("cid"), all.x = TRUE)
wvs <- wvs %>%
        filter(is.na(country) == FALSE)

wvs$country.year <- paste(wvs$country, wvs$survey.year, sep = " - ")
countries <- unique(wvs$country.year)

#loop through countries, run model and create 

for (c in 1:length(countries)) {
        d <- wvs %>%
                filter(wvs$country.year == countries[c])
        #model
        m <- glm(conf_govd ~ as.factor(sex) + age + as.factor(uni) + as.factor(hs) + 
                          income + as.factor(unemp) + as.factor(polinterestd), 
                                data = d, family = "binomial")
        
        #build data set of predicted values
        p <- data.frame(matrix(nrow = 174, ncol = 8))
        colnames(p) <- c("countryyr", "sex", "age", "uni", "hs", "income", "unemp", "polinterestd")
        p$countryyr <- d[1, "country.year"]
        p$cyr_n <- c
        p$sex <- 2
        p$age <- seq(from = 18, to = 75, by = 1)
        p$uni <- rep(c(1, 0, 0), each = 58)
        p$hs <- rep(c(0, 1, 0), each = 58)
        p$income <- mean(d$income, na.rm = TRUE)
        p$unemp <- 0
        p$polinterestd <- ifelse(mean(d$polinterestd, na.rm = TRUE) > 0.5, 1, 0)
        p$category <- rep(c("College", "High School", "< High School"), each = 58)
        
        p2 <- cbind(p, predict(m, newdata = p, type = "link", se = TRUE))
        
        p2 <- within(p2, {
                predictedprob <- plogis(fit)
                LL <- plogis(fit - (1.96 * se.fit))
                UL <- plogis(fit + (1.96 * se.fit))
        })
                
        if(c == 1) {
                data_predict <- p2
        } else data_predict <- rbind(data_predict, p2)
        
}
data_predict$category <- factor(data_predict$category, levels = c("College", "High School", "< High School"))

write.csv(data_predict, file = "20141209_data_forapp.csv")
save(data_predict, file = "wvs.app.RData")
