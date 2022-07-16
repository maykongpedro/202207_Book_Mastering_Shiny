
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
    )
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)