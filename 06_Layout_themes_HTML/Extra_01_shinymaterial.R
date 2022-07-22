

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
        )
        
    ),
    
    shinymaterial::material_row(
        shinymaterial::material_column(
            width = 3,
            shinymaterial::material_radio_button(
                input_id = "radio",
                label = "Escolha entre duas opções",
                choices = c(
                    "Claro" = "claro",
                    "Escuro" = "escuro"
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
        )
    )

    
)

server <- function(input, output, session) {

}

shinyApp(ui, server)