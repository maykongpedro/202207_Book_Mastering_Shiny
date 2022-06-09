
# Book Mastering Shiny --------------------------------------
# 9. Uploads and downloads ----------------------------------

# https://mastering-shiny.org/action-transfer.html
# Script 2 - Understanding  the uploaded files
# Objective: upload one file, validate extension, and see the head of the file


library(shiny)

ui <- fluidPage(
    
    # input
    fileInput(
        inputId = "upload",
        label = NULL,
        accept = c(".csv", ".tsv") # permited only that extension files
    ),
    
    # input
    numericInput(
        inputId = "n",
        label = "Rows",
        value = 5,
        min = 1,
        step = 1
    ),
    
    # output
    tableOutput(outputId = "head")
    
)


server <- function(input, output, session) {
    
    # reactive uploaded data
    data <- reactive({
        
        # need to not generate error
        req(input$upload)
        
        # get extension of the uploaded file
        ext <- tools::file_ext(input$upload$name)
        
        switch(
            ext,
            csv = vroom::vroom(input$upload$datapath, delim = ","),
            tsv = vroom::vroom(input$upload$datapath, delim = "\t"),
            
            # if the previous options are not activated, then do a validade message
            validate("Invalid file; Please upload a .csv ou .tsv file")
        )
        
    })
    
    
    output$head <- renderTable({
        head(data(), input$n)
    })
    
}

shinyApp(ui, server)