
# Book Mastering Shiny --------------------------------------
# 06. Layout, themes, HTML ----------------------------------

# https://mastering-shiny.org/action-layout.html
# Script 02 - Multi-row
# Objective: build a simple app with multi-rows in a fluidPage

library(shiny)

ui <- fluidPage(
    
    fluidRow(
        column(
            width = 4,
            # insert inputs
            sliderInput(
                inputId = "n",
                label = "N",
                min = 0,
                max = 10,
                value = 5
            )
        ),
        column(
            width = 8,
            # insert inputs
            sliderInput(
                inputId = "n2",
                label = "N",
                min = 0,
                max = 50,
                value = 25
        )
    ),
    
    fluidRow(
        column(
            width = 6,
            # insert inputs/outputs
            selectInput(
                inputId = "ch1",
                label = "Choices1",
                choices = c("1", "2", "3")
            )
        ),
        column(
            width = 6,
            # inser inputs/outputs
            # insert inputs/outputs
            selectInput(
                inputId = "ch2",
                label = "Choices2",
                choices = c("A", "B", "C")
            )
        )
    )
)
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)