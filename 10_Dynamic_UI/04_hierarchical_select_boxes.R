
# Book Mastering Shiny --------------------------------------
# 10. Dynamic UI --------------------------------------------

# https://mastering-shiny.org/action-dynamic.html
# Script 04 - Hierarchical select boxes
# Objective: allow interactive drill down across multiple categories


# Load packages -----------------------------------------------------------
library(shiny)


# Get data ----------------------------------------------------------------

# read data
sales <- vroom::vroom(
    file = "../10_Dynamic_UI/sales_data_sample.csv",
    col_types = list(),
    na = ""
    ) |> janitor::clean_names()

# see structure
# sales |> dplyr::glimpse()


# arrange data
sales |> 
    dplyr::select(territory, customername, ordernumber, everything()) |> 
    dplyr::arrange(ordernumber)


# The logic of the data follow a natural hierarchy in:
# Each territory contains customers.
# Each customer has multiple orders.
# Each order contains rows.

# The ideia is to create a user interface where we can:
# Select a territory to see all customers.
# Select a customer to see all orders.
# Select an order to see the underlying rows


ui <- fluidPage(
    selectizeInput(
        inputId = "territory",
        label = "Territory",
        choices = unique(sales$territory)
    ),
    
    selectInput(
        inputId = "customername",
        label = "Customer",
        choices = NULL # will be dynamically generated
    ),
    
    selectInput(
        inputId = "ordernumber",
        label = "Order number",
        choices = NULL # will be dynamically generated
    ),
    
    tableOutput(outputId = "preview_data")
)

server <- function(input, output, session) {
  
  
  # create a reactive base with the territory filtered ------------------------
  territory_data <- reactive({
    sales |> dplyr::filter(territory == input$territory)
  })
  
  # first update - using territory filtered data to update customer name
  observeEvent(territory_data(), {
    
    # generate new choices
    new_choices <- unique(territory_data()$customername)
    
    # tidy way
    # new_choices <- territory_data() |>
    #   dplyr::distinct(customername) |>
    #   dplyr::pull(customername)
    
    # update input
    updateSelectInput(
      inputId = "customername",
      choices = new_choices
    )
    
  })
  
  
  # create a reactive base with the customername filtered ---------------------
  customer_data <- reactive({
    req(input$customername)
    territory_data() |> dplyr::filter(customername == input$customername)
  })
  
  # second update - using customername filtered data to update ordernumbers
  observeEvent(customer_data(), {
    
    # generate new choices
    new_choices <- unique(customer_data()$ordernumber)
    
    # update input
    updateSelectInput(
      inputId = "ordernumber",
      choices = new_choices
    )
  })
  
  
  # output to show data -------------------------------------------------------
  output$preview_data <- renderTable({
    
    # require order number input
    req(input$ordernumber)
    
    # filter data and select some columns
    customer_data() |> 
      dplyr::filter(ordernumber == input$ordernumber) |> 
      dplyr::select(
        quantityordered,
        priceeach,
        productcode
      )
  })
  
}

shinyApp(ui, server)

