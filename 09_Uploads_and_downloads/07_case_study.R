
# Book Mastering Shiny --------------------------------------
# 9. Uploads and downloads ----------------------------------

# https://mastering-shiny.org/action-transfer.html
# Script 7 - Case study
# Objective: a small case study where we upload a file (with user 
# supplied separator), preview it, perform some optional transformations 
# using the janitor package, by Sam Firke, and then let the user download 
# it as a .tsv.

library(shiny)


#To make it easier to understand how to use the app, we used sidebarLayout() 
# to divide the app into three main steps:



# 1.Uploading and parsing the file ----------------------------------------

ui_upload <- sidebarLayout(
    sidebarPanel = sidebarPanel(
        
        fileInput(
            inputId = "file",
            label = "Data",
            buttonLabel = "Upload..."
        ),
        
        textInput(
            inputId = "delim",
            label = "Delimiter (leave blank to guess)",
            value =  ""
        ),
        
        numericInput(
            inputId = "skip",
            label = "Rows to skip",
            value = 0,
            min = 0
        ),
        
        numericInput(
            inputId = "rows",
            label = "Rows to preview",
            value = 10,
            min = 1
        )
        
    ),
    
    mainPanel = mainPanel(
        h3("Raw data"),
        tableOutput(
            outputId = "preview1"
        )
    )
)


# 2.Cleaning the file -----------------------------------------------------




# 3. Downloading the file -------------------------------------------------




# Ui ----------------------------------------------------------------------



# Server ------------------------------------------------------------------




server <- function(input, output, session) {
  
}

shinyApp(ui, server)