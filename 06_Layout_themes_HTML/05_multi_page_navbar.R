
# Book Mastering Shiny --------------------------------------
# 06. Layout, themes, HTML ----------------------------------

# https://mastering-shiny.org/action-layout.html
# Script 05 - Multi-page: navbarPage
# Objective: build a simple app with multi-pages using navbarPage and navbarMenu

library(shiny)

ui <- navbarPage(
    title = "Título principal",
    
    # paineis principais
    tabPanel(title = "Painel 1",value = "um"),
    tabPanel(title = "Painel 2",value = "dois"),
    tabPanel(title = "Painel 3",value = "três"),
    
    # subpaineis no painel 4
    navbarMenu(title = "Subpaineis",
        tabPanel(title = "Painel 4a", value = "Quatro-a"),
        tabPanel(title = "Painel 4b", value = "Quatro-b"),
        tabPanel(title = "Painel 4c", value = "Quatro-c")
    )
)


server <- function(input, output, session) {
  
}

shinyApp(ui, server)
