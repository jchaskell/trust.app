library(shiny)

shinyUI(fluidPage(
        #main title
        titlePanel("Education, Youth, and Confidence in the State"),
        
        sidebarLayout(
                sidebarPanel(
                        htmloutput(
                                p(span("This app examines the relationship between youth, education,
                                  and support for authoritarian government. It uses World Values 
                                  Survey data (Wave 6) and models confidence in the central 
                                  government as a function of age, level of education, and
                                  a few other control variables in each country. Note: This 
                                  is a first draft (of both the model and the app).", 
                                       style = "color:DarkslateBlue")),
                        selectInput("cyr",
                                    label = "Choose a country year",
                                    choices = c("% White", "% Black",
                                                "% Hispanic", "% Asian"),
                                    selected = "% White"),
                        
                ),