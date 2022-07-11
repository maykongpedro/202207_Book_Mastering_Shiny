
# Book Mastering Shiny --------------------------------------
# 10. Dynamic UI --------------------------------------------

# https://mastering-shiny.org/action-dynamic.html
# Script 01 - Updating inputs
# Objective: The app has two inputs that control the range (the min and max) of 
# another input, a slider. The key idea is to use observeEvent()
# to trigger updateSliderInput() whenever the min or max inputs change.

library(shiny)

ui <- fluidPage(
    
    # min number to slider
    numericInput(
        inputId = "min",
        label = "Mínimo",
        value = 0
    ),
    
    # max number to slider
    numericInput(
      inputId = "max",
      label = "Máximo",
      value = 3
     ),
    
    # slider to see the differences
    sliderInput(
        inputId = "n",
        label = "n",
        min = 0,
        max = 3,
        value = 1
    )
    
)

server <- function(input, output, session) {
    
    # update min
    observeEvent(input$min, {
        updateSliderInput(
            inputId = "n",
            min = input$min
        )
    }
    )
    
    # update max
    observeEvent(input$max, {
        updateSliderInput(
            inputId = "n",
            max = input$max
        )
    }
    )
  
}

shinyApp(ui, server)
