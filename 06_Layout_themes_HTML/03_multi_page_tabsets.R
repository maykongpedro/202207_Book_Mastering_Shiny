
# Book Mastering Shiny --------------------------------------
# 06. Layout, themes, HTML ----------------------------------

# https://mastering-shiny.org/action-layout.html
# Script 03 - Multi-page: Tabsets
# Objective: build a simple app with multi-pages using tabsetPanel and tabPanel

# As your app grows in complexity, it might become impossible to fit everything on 
# a single page. In this section you’ll learn various uses of tabPanel() that 
# create the illusion of multiple pages. This is an illusion because you’ll still 
# have a single app with a single underlying HTML file, but it’s now broken into 
# pieces and only one piece is visible at a time.
# 
# Multi-page apps pair particularly well with modules, which you’ll learn about 
# in Chapter 19. Modules allow you to partition up the server function in the same 
# way you partition up the user interface, creating independent components that 
# only interact through well defined connections.

library(shiny)

ui <- fluidPage(
    
    tabsetPanel(
        tabPanel(
            title = "Importar dados",
            
            # inputs/outputs
            fileInput(
                inputId = "file",
                label = "Dados",
                buttonLabel = "Upload..."
            ),
            
            textInput(
                inputId = "delim",
                label = "Delimitador (deixe em braco caso não saiba)",
                value = ""
            ),
            
            numericInput(
                inputId = "skip",
                label = "Linhas para ignorar",
                value = 0,
                min = 0
            ),
            
            numericInput(
                inputId = "rows",
                label = "Linhas para visualizar",
                value = "10",
                min = 1
            )
        ),
        
        tabPanel(title = "Definir parâmetros"),
        tabPanel(title = "Visualizar resultados")
    )
    
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)