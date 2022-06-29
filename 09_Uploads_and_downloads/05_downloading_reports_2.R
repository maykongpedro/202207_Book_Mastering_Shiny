
# Book Mastering Shiny --------------------------------------
# 9. Uploads and downloads ----------------------------------

# https://mastering-shiny.org/action-transfer.html
# Script 5 - Downloading reports - update path
# Objective: download a report that summarises the result of a interactive exploration
#            in a shiny app - using a temporary path

library(shiny)



# Temporary path ----------------------------------------------------------

# create a temporary directory
report_path <- tempfile(fileext = ".Rmd")

# copy the report to that directory
file.copy(
    from = "report.Rmd",
    to = report_path,
    overwrite = TRUE
    )

# Why I do that?
# RMarkdown works in the current working directory, which will fail in many 
# deployment scenarios (e.g. on shinyapps.io). You can work around this by 
# copying the report to a temporary directory when your app starts 
# (i.e. outside of the server function):


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
                input = report_path,
                output_file = file,
                params = params,
                envir = new.env(parent = globalenv())
            )
            
        }
    )
    
}

shinyApp(ui, server)