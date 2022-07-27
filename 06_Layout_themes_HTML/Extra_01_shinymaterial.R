
# https://ericrayanderson.github.io/shinymaterial/
# Script Extra 01 - Shinymaterial
# Objective: Testing the shinymaterial layout and inputs

library(shiny)

ui <- shinymaterial::material_page(
    
    shinymaterial::material_row(
        
        shinymaterial::material_column(
            width = 6,
            shinymaterial::material_slider(
                input_id = "inp",
                label = "Test",
                min_value = 0,
                max_value = 10,
                initial_value = 5,
                # color = "#2e7d32"
            )
        ),
        
        shinymaterial::material_column(
            width = 3,
            shinymaterial::material_checkbox(
                input_id = "check",
                label = "Checkbox",
                initial_value = FALSE
            )
        ),
        
        
        shinymaterial::material_column(
            width = 3,
            shinymaterial::material_card(
                title = "Example",
                plotOutput(outputId = "plot_example")
            )
        ),
        
    ),
    
    shinymaterial::material_row(
        shinymaterial::material_column(
            width = 3,
            
            shinymaterial::material_card(
                title = "Radio buttons",
                shinymaterial::material_radio_button(
                    input_id = "radio",
                    label = "Escolha entre duas opções",
                    choices = c(
                        "Claro" = "claro",
                        "Escuro" = "escuro"
                    )
                )
            )

        ),
        
        shinymaterial::material_column(
            width = 3,
            shinymaterial::material_switch(
                input_id = "switch",
                off_label = "Não",
                on_label = "Sim",
                initial_value = TRUE,
                # color = "#2e7d32"
            )
        ),
        
        shinymaterial::material_column(
            width = 3,
            shinymaterial::material_button(
                input_id = "example_button",
                label = "BUTTON"
            )
        ),
        
        shinymaterial::material_column(
            width = 3,
            shinymaterial::material_dropdown(
                input_id = "example_dropdown",
                label = "Dropdown",
                choices = c(
                    "Chicken" = "c",
                    "Steak" = "s",
                    "Fish" = "f"
                ),
                selected = "s"
            )
        )
    )

    
)

server <- function(input, output, session) {

}

shinyApp(ui, server)