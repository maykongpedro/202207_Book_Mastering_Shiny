
# https://appsilon.github.io/shiny.semantic/
# Script Extra 02 - Shiny.semantic
# Objective: Create a simple app with semantic.ui using shiny.semantic package

# How to use it?
# Firstly, we have to invoke shinyUI() with semanticPage() instead of
# standard Shiny UI definitions like e.g. bootstrapPage(). From now on, all
# components can be annotated with Fomantic UI specific CSS classes and also 
# you will be able to use shiny.semantic components.

library(shiny)
library(shiny.semantic)

# ui using shiny ----------------------------------------------------------

# ui <- fluidPage(
#     div(
#         div(
#             a("Link"),
#             p("Lorem ipsum, lorem ipsum, lorem ipsum"),
#             actionButton("button", "Click")
#         )
#     )
# )



# Example 1: ui using shiny.semantic --------------------------------------

ui <- semanticPage(

    # criar uma classe html
    div(class = "ui raised segment",

        div(
            # classe html
            a(class = "ui green ribbon label", "Link"),

            # texto html
            p("Um texto aleatório colocado aqui"),

            # input
            actionButton(inputId = "botao", label = "Click")
        )
    )
)


# Example 2: a simple button ----------------------------------------------

# ui <- semanticPage(
#     title = "My page",
#     div(class = "ui button", icon("user"),  "Icon button")
# )



# Server ------------------------------------------------------------------

server <- function(input, output, session) {
  
}

shinyApp(ui, server)