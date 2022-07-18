
# Book Mastering Shiny --------------------------------------
# 06. Layout, themes, HTML ----------------------------------

# https://mastering-shiny.org/action-layout.html
# Script 01 - Page with sidebar
# Objective: build a simple app with the sidebar layout


library(shiny)

# Layout functions provide the high-level visual structure of an app. 
# Layouts are created by a hierarchy of function calls, where the hierarchy in 
# R matches the hierarchy in the generated HTML. This helps you understand layout 
# code. For example, when you look at layout code like this:

ui <- fluidPage(
    titlePanel(
        # app title/description
        "Teorema do limite central"
    ),
    sidebarLayout(
        sidebarPanel(
            # inputs
            numericInput(
                inputId = "m",
                label = "Número de amostras:",
                value = 2,
                min = 1,
                max = 100
            )
            
        ),
        mainPanel(
            # outputs
            plotOutput("hist")
        )
    )
)


server <- function(input, output, session){
    output$hist <- renderPlot({
        
        means <- replicate(
            n = 10000,
            expr = mean(runif(input$m))
        )
        
        hist(means, breaks = 20)
    
    }, res = 96)
}

shinyApp(ui, server)
