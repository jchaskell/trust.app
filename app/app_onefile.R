library(ggplot2)
library(shiny)
library(devtools)

shinyApp(
        ui = fluidPage(
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
                )),
        server = function(input, output) {
                #source_gist("4466237")
                
                data_predict <- read.csv("C:/Dropbox/Projects/Dissertation/WVS/trust.app/20141209_data_forapp.csv")
                output$plot <- renderPlot(function(){
                        selection <- input$countryyr      
                        #                 selection <- switch(input$countryyr,
                        #                                     "Algeria - 2014" = "Algeria - 2014", "Azerbaijan - 2011/2012" = "Azerbaijan - 2011/2012", "Armenia - 2011" = "Armenia - 2011",  "Belarus - 2011" = "Belarus - 2011", "China - 2012" = "China - 2012", "Palestine - 2013" = "Palestine - 2013", "Iraq - 2013" = "Iraq - 2013", "Kazakhstan - 2011" = "Kazakhstan - 2011", "Jordan - 2014" = "Jordan - 2014", "Kuwait - 2013" = "Kuwait - 2013", "Libya - 2013" = "Libya - 2013", "Malaysia - 2011" = "Malaysia - 2011", "Morocco - 2011" = "Morocco - 2011", "Nigeria - 2011" = "Nigeria - 2011", "Qatar - 2010" = "Qatar - 2010", "Russia - 2011" = "Russia - 2011", "Rwanda - 2012" = "Rwanda - 2012", "Singapore - 2012" = "Singapore - 2012", "Zimbabwe - 2011" = "Zimbabwe - 2011", "Egypt - 2012" = "Egypt - 2012", "Uzbekistan - 2011" = "Uzbekistan - 2011", "Yemen - 2013" = "Yemen - 2013")
                        #                 
                        data <- subset(data_predict, cyr_n == input$countryyr) 
                        p <- ggplot(data, aes(x =age, y = predictedprob)) + 
                                theme_bw() +
                                theme(#axis.line = element_line(colour = "black"),
                                        #plot.background = element_blank(),
                                        #                               panel.grid.minor= element_blank(),
                                        #                               panel.grid.major.x = element_blank(),
                                        #                               panel.grid.major.y = element_blank(),
                                        panel.border = element_blank(),
                                        panel.background = element_blank()) +  
                                geom_ribbon(aes(ymin = LL, ymax = UL, fill = category), alpha = 0.2) + 
                                geom_line(aes(color = category), size = 1.2) +
                                xlab("Age") + ylab("Probability of Trust")
                        print(p)
                        
                })
                
             
        }
        
        
        )