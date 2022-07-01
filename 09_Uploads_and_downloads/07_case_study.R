
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

ui_clean <- sidebarLayout(
  
  sidebarPanel = sidebarPanel(
    
    checkboxInput(
      inputId = "snake",
      label = "Rename columns to snake case?"
    ),
        
    checkboxInput(
      inputId = "constant",
      label = "Remove constant columns?"
    ),
        
    checkboxInput(
      inputId = "empty",
      label = "Remove empty cols?"
    )
    
  ),
  
  mainPanel = mainPanel(
    h3("Cleaner data"),
    tableOutput("preview2")
  )
)


# 3. Downloading the file -------------------------------------------------

ui_download <- fluidRow(
  
  column(
    
    width = 12,
    
    downloadButton(
      outputId = "download",
      class = "btn-block"
    )
    
  )
)


# Ui ----------------------------------------------------------------------

ui <- fluidPage(
  ui_upload,
  ui_clean,
  ui_download
)


# Server ------------------------------------------------------------------

server <- function(input, output, session) {
  

  # Upload ----------------------------------------------------------------
  raw_data <- reactive({
    
    req(input$file)
    
    delim <- if(input$delim == "") NULL else input$delim
    
    vroom::vroom(
      file = input$file$datapath,
      delim = delim,
      skip = input$skip
    )
    
  })
  
  output$preview1 <- renderTable(
    expr = head(
      x = raw(),
      n = input$rows
      )
  )


  # Clean -----------------------------------------------------------------


  
  # Download --------------------------------------------------------------


  
}

shinyApp(ui, server)































