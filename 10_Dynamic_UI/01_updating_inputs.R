
# Book Mastering Shiny --------------------------------------
# 10. Dynamic UI --------------------------------------------

# https://mastering-shiny.org/action-dynamic.html
# Script 01 - Updating inputs
# Objective: The app has two inputs that control the range (the min and max) of 
# another input, a slider. The key idea is to use observeEvent()
# to trigger updateSliderInput() whenever the min or max inputs change.

library(shiny)

ui <- fluidPage(
    
  numericInput(
      inputId = "min",
      label = "Mínimo",
      value = 0
  ),
  
  numericInput(
      inputId = "max",
      label = "Máximo",
      value = 3
  ),
  
  sliderInput(
      inputId = "n",
      label = "n",
      min = 0,
      max = 3,
      value = 1
  )
  
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)