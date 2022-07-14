
# Book Mastering Shiny --------------------------------------
# 10. Dynamic UI --------------------------------------------

# https://mastering-shiny.org/action-dynamic.html
# Script 03 - Simple uses 2
# Objective: tweak the text of an action button so you know exactly what it’s
# going to do.

library(shiny)

ui <- fluidPage(
    
    numericInput(inputId = "n", label = "Simulações", value = 10),
    actionButton(inputId = "simulate", label = "Simular")
    
)

server <- function(input, output, session) {
    
    observeEvent(input$n, {
        
        label <- paste0("Simular ", input$n, " times")
        updateActionButton(inputId = "simulate", label = label)
        
    })
    
}

shinyApp(ui, server)