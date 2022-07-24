
# Book Mastering Shiny --------------------------------------
# 06. Layout, themes, HTML ----------------------------------

# https://mastering-shiny.org/action-layout.html
# Script 08 - Themes: plot themes
# Objective: build a simple app with a plot theme talking with the shiny theme

# If you’ve heavily customised the style of your app, you may want to also 
# customise your plots to match. Luckily, this is really easy thanks to the 
# thematic package which automatically themes ggplot2, lattice, and base plots. 
# Just call thematic_shiny() in your server function. This will automatically
# determine all of the settings from your app theme.

library(shiny)

ui <- fluidPage(
  theme = bslib::bs_theme(bootswatch = "darkly"),
  titlePanel(title = "Um gráfico com tema"),
  plotOutput(outputId = "plot")
)

server <- function(input, output, session) {
    thematic::thematic_shiny()
    
    output$plot <- renderPlot({
        
        mtcars |> 
            ggplot2::ggplot() +
            ggplot2::aes(
                x = wt,
                y = mpg
            ) +
            ggplot2::geom_point()+
            ggplot2::geom_smooth()
        
    }, res = 96)
}

shinyApp(ui, server)

