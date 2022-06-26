
# Book Mastering Shiny --------------------------------------
# 9. Uploads and downloads ----------------------------------

# https://mastering-shiny.org/action-transfer.html
# Script 4 - Downloading reports
# Objective: download a report that summarises the result of a interactive exploration
#            in a shiny app

library(shiny)

ui <- fluidPage(
    
    sliderInput(
        inputId = "n",
        label = "Number of points",
        min = 1,
        max = 100,
        value = 50
    ),
    
    downloadButton(
        outputId = "report",
        label = "Generate report"
    )
  
)

server <- function(input, output, session) {
    
    output$report <- downloadHandler(
        filename = "repor.html",
        content = function(file) {
            
            # params to the report
            params <- list(n = input$n)
            
            # notification message
            id <- showNotification(
                ui = "Rendering report...",
                duration = NULL,
                closeButton = FALSE
            )
            
            # call notificaiton
            on.exit(
                expr = shiny::removeNotification(id = id),
                add = TRUE
            )
            
            rmarkdown::render(
                input = "report.Rmd",
                output_file = file,
                params = params,
                envir = new.env(parent = globalenv())
            )
            
        }
    )
    
}

shinyApp(ui, server)