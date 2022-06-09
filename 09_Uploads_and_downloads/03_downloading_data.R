
# Book Mastering Shiny --------------------------------------
# 9. Uploads and downloads ----------------------------------

# https://mastering-shiny.org/action-transfer.html
# Script 3 - Downloading files
# Objective: 

library(shiny)

ui <- fluidPage(
    
    # input
    selectInput(
        inputId = "dataset",
        label = "Pick a dataset",
        choices = ls("package:datasets")
    ),
    
    # output
    tableOutput(outputId = "preview"),
    
    # output
    downloadButton(
        outputId = "download",
        label = "Download .tsv"
    )
    
)


server <- function(input, output, session) {
    
    data <- reactive({
        
        # get dataset
        out <- get(input$dataset, "package:datasets")
        
        # check if the dataset is a dataframe
        if(!is.data.frame(out)) {
            
            validate(
                paste0(
                    "'",
                    input$dataset,
                    "' is not a data frame"
                )
            )
            
        }
        
        # return dataset as data()
        out
        
    })
    
    
    output$preview <- renderTable({
        head(data())
    })
    
    
    output$download <- downloadHandler(
        
        filename = function() {
            paste0(input$dataset, ".tsv")
        },
        
        content = function(file) {
            vroom::vroom_write(
                x = data(), 
                file = file
            )
        }
    )
    
}

shinyApp(ui, server)
