rm(list = ls())

library(shiny)
library(ggplot2)
library(devtools)

shinyServer(function(input, output) {
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
        
        
       
#         gv <- reactive({
#                 datasetInput() %>%
#                 ggvis(x = ~age, y = ~predictedprob, stroke = ~category)  %>% 
#                         layer_lines()       %>% 
#                         add_title(x_lab = "Age", y_lab = "Prob of Trust")
#                         group_by(category) %>%
#                         layer_ribbons(y = ~LL, y2 = ~UL, stroke = ~category) 
#                 #                               layer_lines(stroke= ~category)  #%>% 
#                 #                               #layer_ribbons(y = ~LL, y2 = ~UL))
#                 
#         }) %>%
#                 bind_shiny("my_plot")
# #         output$controls <- renderControls(gv)
# #         observe_ggvis(gv, "trust_plot", session)      
})

# p <- ggplot(newdata3, aes(x = age_2, y = PredictedProb)) + 
#geom_ribbon(aes(ymin = LL, ymax = UL, fill = category), alpha = 0.2) + geom_line(aes(color = category), size = 1.5) + labs(title = "China")
# p

        
        
        