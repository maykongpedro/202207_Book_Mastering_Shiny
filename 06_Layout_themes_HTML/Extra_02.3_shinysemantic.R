library(shiny)
# library(shinydashboard) # <-- Change this line to: library(semantic.dashboard)
library(semantic.dashboard)

ui <- dashboardPage(
    dashboardHeader(title = "Basic dashboard"),
    dashboardSidebar(sidebarMenu(
        menuItem(tabName = "home", text = "Home", icon = icon("home")),
        menuItem(tabName = "another", text = "Another Tab", icon = icon("heart"))
    )),
    dashboardBody(
        fluidRow(
            box(
                title = "Gráfico",
                width = 6,
                plotOutput("plot1", height = 250)),
            box(
                title = "Controls",
                width = 3,
                sliderInput("slider", "Number of observations:", 1, 100, 50)
            ),
            box(
                title = "Input normal",
                width = 3,
                selectInput(inputId = "selinput", 
                            label = "Opções:", 
                            choices = c(
                                "A", "B", "C"
                            ))
            )
            
        ),
        fluidRow(
            box(
                title = "Radio buttons",
                width = 5,
                # radioButtons(
                #     inputId = "radio",
                #     label = "Escolha um:",
                #     choices = c("op1", "op2"),
                #     selected = "op1"
                # )
            )
        )
    ),
    theme = "simplex"
)

server <- function(input, output) {
    set.seed(122)
    histdata <- rnorm(500)
    output$plot1 <- renderPlot({
        data <- histdata[seq_len(input$slider)]
        hist(data)
    })
}

shinyApp(ui, server)