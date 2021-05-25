#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)


df <- read.csv("dataframe.csv")

ui <- fluidPage(
    
    titlePanel("ADHD traits, Depression Symptoms and Emotion Regulation Domains"),
    
    sidebarPanel(
        
      
        selectInput('x', 'Reported Depression Symptoms', list("Depression Score" = "cesd")),
        selectInput('y', 'ADHD trait type', list(Innatentive = "iasrs", Hyperactive = "hasrs")),
        selectInput('ders', 'Emotion Regulation Difficulties per Domain', c(list("Non-Acceptance" = "nonaccept", Goals = "goals", Impulse = "impulse", Awareness = "awareness", Strategies = "strategies", Clarity = "clarity"))),
        #selectInput('size', 'Size', c(list("Non-Acceptance" = "nonaccept", Goals = "goals", Impulse = "impulse", Awareness = "awareness", Strategies = "strategies", Clarity = "clarity")))
    
    ),
    
    mainPanel(
        plotOutput('plot')
    )
)

server <- function(input, output) {
    
    
    output$plot <- renderPlot({
       
        p <- ggplot(df, aes_string(x=input$x, y=input$y)) + geom_point()
        
        (input$color)
            p <- p + aes_string(color=input$ders)
            
        (input$size)
            p <- p + aes_string(size=input$ders) + guides(size = guide_legend(reverse = TRUE))
        

        print(p)
        
    }, height=700)
    
}
# Run the application 
shinyApp(ui = ui, server = server)
