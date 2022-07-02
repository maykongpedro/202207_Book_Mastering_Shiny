
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

# 1.Uploading and parsing the file
# 2.Cleaning the file
# 3. Downloading the file

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
    
    # require input
    req(input$file)
    
    # delimitator of the file
    delim <- if(input$delim == "") NULL else input$delim
    
    # read file
    vroom::vroom(
      file = input$file$datapath,
      delim = delim,
      skip = input$skip
    )
    
  })
  
  # table preview of the data
  output$preview1 <- renderTable(
    expr = head(
      x = raw_data(),
      n = input$rows
      )
  )

  # Clean -----------------------------------------------------------------
  
  tidied_data <- reactive({
    
    # get raw data
    out <- raw_data()
    
    # rename columns to snake case
    if (input$snake) {
      names(out) <- janitor::make_clean_names(names(out))
    }
    
    # remove empty columns
    if (input$empty) {
      out <- janitor::remove_empty(
        dat = out,
        which = "cols"
      )
    }
    
    # remove constant columns
    if (input$constant) {
      out <- janitor::remove_constant(out)
    }
    
    # return transformed data in out
    out
    
  })
  
  # table preview of tidied data
  output$preview2 <- renderTable(
    expr = head(
      x = tidied_data(),
      n = input$rows
    )
  )

  # Download --------------------------------------------------------------
  output$download <- downloadHandler(
    
    filename = function(){
      
      # get complete name of the file without extension
      file_path <- tools::file_path_sans_ext(input$file$name)
      paste0(file_path,".tsv")
    },
    
    content = function(file){
      
      # export tidied data
      vroom::vroom_write(
        x = tidied_data(), 
        file = file
        )
      
    }
  )

  
}

shinyApp(ui, server)
