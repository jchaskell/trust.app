rm(list = ls())

library(shiny)
library(ggplot2)
library(devtools)

shinyUI(fluidPage(
                fluidRow(
                        column(8,
                                selectInput("countryyr", label = "Choose a country:", 
                                c("Algeria - 2014" = 1, "Azerbaijan - 2011/2012" = 2, 
                                "Armenia - 2011" = 3,  "Belarus - 2011" = 3, "China - 2012" = 4, 
                                "Palestine - 2013" = 5, "Iraq - 2013" = 6, "Kazakhstan - 2011" = 7, 
                                "Jordan - 2014"= 8, "Kuwait - 2013" = 9, "Libya - 2013" = 10, 
                                "Malaysia - 2011" = 11, "Morocco - 2011" = 12, "Nigeria - 2011" = 13,
                                "Qatar - 2010" = 14, "Russia - 2011" = 15, "Rwanda - 2012" = 16, 
                                "Singapore - 2012" = 17, "Zimbabwe - 2011" = 18, "Egypt - 2012" = 19,
                                "Uzbekistan - 2011" = 20, "Yemen - 2013" = 21), selected = 1))),
                             
                mainPanel(
                        #uiOutput("ggvis_ui"),
                        plotOutput('plot')
                  )))