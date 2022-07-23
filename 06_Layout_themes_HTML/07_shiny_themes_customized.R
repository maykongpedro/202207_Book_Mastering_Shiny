
# Book Mastering Shiny --------------------------------------
# 06. Layout, themes, HTML ----------------------------------

# https://mastering-shiny.org/action-layout.html
# Script 07 - Themes: shiny themes - customized
# Objective: build a simple app with a customized bs_theme

# The easiest way to change the overall look of your app is to pick a premade 
# “bootswatch” theme using the bootswatch argument to bslib::bs_theme()

# Alternatively, we can construct your own theme using the other arguments to 
# bs_theme() like bg (background colour), fg (foreground colour) and base_font

library(shiny)

customized_theme <- bslib::bs_theme(
    bg = "#0b3d91", 
    fg = "white",
    base_font = "Source Sans Pro"
)

# An easy way to preview and customise your theme is to use 
# bslib::bs_theme_preview(theme). This will open a Shiny app that shows what 
# the theme looks like when applied many standard controls, and also provides 
# we with interactive controls for customising the most important parameters.
# bslib::bs_theme_preview(theme)


ui <- fluidPage(
    # theme = bslib::bs_theme(bootswatch = "darkly"),
    theme = customized_theme,
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