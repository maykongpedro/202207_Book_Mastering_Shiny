
# Book Mastering Shiny --------------------------------------
# 06. Layout, themes, HTML ----------------------------------

# https://mastering-shiny.org/action-layout.html
# Script 04 - Multi-page: Navlists
# Objective: build a simple app with multi-pages using navList() with tabPanel

# Because tabs are displayed horizontally, there’s a fundamental limit to how many 
# tabs you can use, particularly if they have long titles. navbarPage()and 
# navbarMenu() provide two alternative layouts that let you use more tabs with 
# longer titles.
# 
# navlistPanel() is similar to tabsetPanel() but instead of running the tab titles
# horizontally, it shows them vertically in a sidebar. It also allows you to add
# headings with plain strings, as shown in the code below

library(shiny)

ui <- fluidPage(
    
    navlistPanel(
        id = "tabset",
        "Título 1",
        tabPanel(
            title = "Painel 1",
            value = "Conteúdo do painel 1"
        ),
        "Título 2",
        tabPanel(
            title = "Painel 2",
            value = "Conteúdo do painel 2"
        ),
        tabPanel(
            title = "Painel 3",
            value = "Conteúdo do painel 3"
        )
    )
  
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)