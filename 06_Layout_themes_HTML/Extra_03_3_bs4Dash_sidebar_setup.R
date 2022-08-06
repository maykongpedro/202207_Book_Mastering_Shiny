library(shiny)
library(bs4Dash)

shinyApp(
    ui = dashboardPage(
        title = "Basic Dashboard",
        header = dashboardHeader(),
        
        sidebar = dashboardSidebar(
            
            sidebarMenu(
                id = "sidebarmenu",
                # flat = TRUE,
                # compact = TRUE,
                sidebarHeader(title = "Título da barra lateral"),
                
                menuItem(
                    "Página 1",
                    tabName = "pag1",
                    icon = icon(name = "sliders")
                ),                
                menuItem(
                    "Página 2",
                    tabName = "pag2",
                    icon = icon(name = "id-card")
                )
                
            )
            
        ),
        
        controlbar = dashboardControlbar(),
        footer = dashboardFooter(),
        body = dashboardBody()
    ),
    server = function(input, output) {}
)
