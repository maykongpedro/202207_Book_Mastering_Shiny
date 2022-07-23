
# Book Mastering Shiny --------------------------------------
# 06. Layout, themes, HTML ----------------------------------

# https://mastering-shiny.org/action-layout.html
# Script 06 - Themes: shiny themes
# Objective: build a simple app with a bs_theme

# The easiest way to change the overall look of your app is to pick a premade 
# “bootswatch” theme using the bootswatch argument to bslib::bs_theme()

library(shiny)

ui <- fluidPage(
    # theme = bslib::bs_theme(bootswatch = "darkly"),
    # theme = bslib::bs_theme(bootswatch = "flatly"),
    theme = bslib::bs_theme(bootswatch = "united"),
    sidebarLayout(
        sidebarPanel(
            textInput(
                inputId = "txt",
                label = "Text input",
                value = "texto aqui"
            ),
            sliderInput(
                inputId = "slider",
                label = "Slider input",
                min = 1,
                max = 100,
                value = 30
            )
        ),
        mainPanel(
            h1("Theme: darkly"),
            h2("Header 2"),
            p("Some text")
        )
    )
  
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)