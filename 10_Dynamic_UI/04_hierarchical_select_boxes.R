
# Book Mastering Shiny --------------------------------------
# 10. Dynamic UI --------------------------------------------

# https://mastering-shiny.org/action-dynamic.html
# Script 04 - Hierarchical select boxes
# Objective: allow interactive drill down across multiple categories


# Get data ----------------------------------------------------------------

# read data
sales <- vroom::vroom(
    file = "10_Dynamic_UI/sales_data_sample.csv",
    col_types = list(),
    na = ""
    ) |> janitor::clean_names()

# see structure
sales |> dplyr::glimpse()

# arrange data
sales |> 
    dplyr::select(territory, customername, ordernumber, everything()) |> 
    dplyr::arrange(ordernumber)
