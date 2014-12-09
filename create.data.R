#This file creates the data for the shiny app

#packages
library(dplyr)
library(plyr)
library(dplyr)
library(ggvis)

#read in WVS data
setwd("C:/Dropbox/Projects/Dissertation/WVS/trust.app")
wvs <- read.csv(file = "wvs_20141208.csv", stringsAsFactors = FALSE)

list <- read.csv(file = "WVSw6_list.csv", stringsAsFactors = FALSE)
wvs <- merge(wvs, list, by = c("cid"), all.x = TRUE)

countries <- unique(wvs$country)

#loop through countries, run model and create 

for (c in 1:leng(countries)) {
        d <- wvs %>%
                filter(wvs$country == countries[c])
        #model
        m1 <- glm(conf_govd ~ as.factor(sex) + age + as.factor(uni) + as.factor(hs) + 
                          income + as.factor(unemp) + as.factor(polinterestd), 
                                data = wvs, family = "binomial")
        
        #build data set of predicted values
        p <- data.frame(matrix(nrow = , ncol = 8))
        colnames(p) <- c("country", "sex", "age_2", "uni", "hs", "income", "unemp", "polinterestd")
        
        if(c == 1) {
                data_predict <- p
        } else data_predict <- rbind(data_predict, p)
        
}

test <- data.frame(matrix(nrow = 174, ncol = 7))
colnames(test) <- c("sex", "age_2", "uni", "hs", "income", "unemp", "polinterestd")
test$sex <- 2
test$age_2 <- seq(from = 18, to = 75, by = 1)
test$uni <- rep(c(1,0,0), each = 58)
test$hs <- rep(c(0, 1, 0), each = 58)
test$income <- mean(china$income, na.rm = TRUE)
test$unemp <- 0
test$polinterestd <- 0
test$category <- rep(c("College", "HS", "Low Edu"), each = 58)

newdata3 <- cbind(test, predict(m, newdata = test, type = "link",
                                se = TRUE))
newdata3 <- within(newdata3, {
        PredictedProb <- plogis(fit)
        LL <- plogis(fit - (1.96 * se.fit))
        UL <- plogis(fit + (1.96 * se.fit))
})

p <- ggplot(newdata3, aes(x = age_2, y = PredictedProb)) + geom_ribbon(aes(ymin = LL, ymax = UL, fill = category), alpha = 0.2) + geom_line(aes(color = category), size = 1.5) + labs(title = "China")
p