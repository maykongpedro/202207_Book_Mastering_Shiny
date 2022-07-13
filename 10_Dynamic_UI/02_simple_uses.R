
# Book Mastering Shiny --------------------------------------
# 10. Dynamic UI --------------------------------------------

# https://mastering-shiny.org/action-dynamic.html
# Script 02 - Simple uses
# Objective: how we combine an actionButton(), observeEvent() and 
# updateSliderInput().

library(shiny)

ui <- fluidPage(
    
    sliderInput(inputId = "x1", label = "x1", value = 0, min = -10, max = 10),
    sliderInput(inputId = "x2", label = "x2", value = 0, min = -10, max = 10),
    sliderInput(inputId = "x3", label = "x1", value = 0, min = -10, max = 10),
    actionButton(inputId = "reset", label = "Resetar")
    
)

server <- function(input, output, session) {
  
    observeEvent(input$reset, {
        
        updateSliderInput(inputId = "x1", value = 0)
        updateSliderInput(inputId = "x2", value = 0)
        updateSliderInput(inputId = "x3", value = 0)
        
    })
    
}

shinyApp(ui, server)
