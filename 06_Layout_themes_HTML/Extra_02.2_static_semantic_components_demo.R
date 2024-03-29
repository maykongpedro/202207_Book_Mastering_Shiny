
# https://github.com/Appsilon/shiny.semantic/blob/develop/examples/app.R
# Script Extra 02.2 - Static Semantic components demo
# Objective:Component examples of the documentation page

library(shiny)
library(shinyjs)
library(magrittr)
library(highlighter) # devtools::install_github("Appsilon/highlighter")
library(formatR)
library(httr)
library(rjson)
library(shiny.semantic)

options(semantic.themes = TRUE)

demo <- function(code) {
    div(class = "ui raised segment",
        code,
        div(style = "width: 100%; height:10px"),
        highlight(formatR::tidy_source(width.cutoff = 40, text = deparse(substitute(code)))$text.tidy)
    )
}

input <- function(class = "ui input", style = "", type = "text", name = "", placeholder = "") {
    div(class = class, style = style,
        tags$input(type = type, name = name, placeholder = placeholder)
    )
}

jsCode <- "
  $('.ui.dropdown').dropdown({});
  $('.rating').rating('setting', 'clearable', true);
"

header <- function() {
    div(
        h1(class="ui header", id="header", "Headers"),
        demo(h1(class="ui header", "First header")),
        demo(h2(class="ui header", "Second header")),
        demo(h2(class="ui icon header",
                icon("settings"),
                div(class="content", "Account Settings",
                    div(class="sub header", "Manage your account")))),
        demo(h2(class="ui header", icon("plug"), div(class="content", "Second header"))),
        demo(h2(class="ui header", icon("settings"),
                div(class="content", "Second header",
                    div(class="sub header", "Manage preferences"))))
    )
}
button <- function() {
    div(
        h1(class="ui header", id="button", "Button"),
        demo(div(class = "ui raised segment", "Raised segment")),
        demo(div(class = "ui button", "Button")),
        demo(div(class = "ui basic button", "Basic button")),
        demo(div(class = "ui basic button", icon("user"), "Icon button")),
        demo(div(class = "ui olive basic button", icon("user"), "Color icon button")),
        demo(div(class = "ui animated button", tabindex="0",
                 div(class="visible content", "Next"),
                 div(class="hidden content", "Step"))),
        demo(div(class = "ui labeled button", tabindex="0",
                 div(class="ui button", icon("heart"), "Like"),
                 a(class="ui basic label", "2,048"))),
        demo(div(class = "ui mini button", "Mini")),
        demo(div(class = "ui tiny button", "Tiny")),
        demo(div(class = "ui small button", "Small")),
        demo(div(class = "ui medium button", "Medium")),
        demo(div(class = "ui large button", "Large")),
        demo(div(class = "ui big button", "Big")),
        demo(div(class = "ui huge button", "Huge")),
        demo(div(class = "ui massive button", "Massive")),
        demo(div(class = "ui red button", "Red")),
        demo(div(class = "ui orange button", "Orange")),
        demo(div(class = "ui yellow button", "Yellow")),
        demo(div(class = "ui olive button", "Olive")),
        demo(div(class = "ui green button", "Green")),
        demo(div(class = "ui teal button", "Teal")),
        demo(div(class = "ui blue button", "Blue")),
        demo(div(class = "ui violet button", "Violet")),
        demo(div(class = "ui purple button", "Purple")),
        demo(div(class = "ui pink button", "Pink")),
        demo(div(class = "ui brown button", "Brown")),
        demo(div(class = "ui grey button", "Grey")),
        demo(div(class = "ui black button", "Black"))
    )
}
counter_button_demo <- function() {
    div(
        h1(class="ui header", id="counter_button", "Counter button"),
        demo(counter_button("counter", "My Counter Button",
                            icon = icon("world"),
                            size = "", color = "purple"))
    )
}

icon_demo <- function() {
    div(
        h1(class="ui header", id="icon", "Icon"),
        demo(icon("home")),
        demo(icon("mini home")),
        demo(icon("tiny home")),
        demo(icon("small home")),
        demo(icon("medium home")),
        demo(icon("large home")),
        demo(icon("big home")),
        demo(icon("huge home")),
        demo(icon("massive home"))
    )
}

step_demo <- function() {
    div(
        h1(class = "ui header", id = "step", "Step"),
        demo(steps(
            id = "steps",
            steps_list = list(
                single_step(
                    id = "step_1",
                    title = "Step 1",
                    description = "It's night?",
                    icon_class = "moon"
                ),
                single_step(
                    id = "step_2",
                    title = "Step 2",
                    description = "Order some food",
                    icon_class = "bug"
                ),
                single_step(
                    id = "step_3",
                    title = "Step 3",
                    description = "Feed the Kiwi",
                    icon_class = "kiwi bird"
                )
            )
        )
        )
    )
}

toast_demo <- function(){
    toast_code <- "toast(
           \"This is a semantic toast. Cheers!\",
           title  = \"Notification\",
           duration = 3,
         )"
    div(
        h1(class="ui header", id="notification", "Notifications"),
        div(class = "ui raised segment",
            action_button("show_toast", "Show notification (toast)!"),
            div(style = "width: 100%; height:10px"),
            highlight(formatR::tidy_source(width.cutoff = 40, text = toast_code)$text.tidy)
        )
    )
}

divider <- function() {
    div(
        h1(class="ui header", id="divider", "Divider"),
        demo(div(class="ui divider")),
        demo(div(class="ui horizontal divider", "Or")),
        demo(div(class="ui horizontal divider", icon("tag"), "Description"))
    )
}
uiinput_demo <- function() {
    div(
        h1(class="ui header", id="input", "Input"),
        demo(numeric_input("ex", "Select number", 10)),
        demo(numericInput("ex", "Select number", 10)),
        demo(textInput("ex", label = "Your text", type = "text", placeholder = "Enter Text")),
        demo(textAreaInput("a", "Area:", width = "200px")),
        demo(date_input("date", value = Sys.Date(), style = "width: 200px;")),
        demo(dateInput("date_2", value = Sys.Date(), style = "width: 200px;")),
        demo(dropdown_input("simple_dropdown", LETTERS, value = "A")),
        demo(uiinput(icon("dog"), numeric_input("input", value = 0, label = "")))
    )
}

breadcrumb <- function() {
    div(
        h1(class="ui header", id="breadcrumb", "Breadcrumb"),
        demo(div(class="ui breadcrumb",
                 a(class="section", "Home"),
                 div(class="divider", "/"),
                 a(class="section", "Store"),
                 div(class="divider", "/"),
                 a(class="section", "T-shirts"))),
        demo(div(class="ui breadcrumb",
                 a(class="section", "Home"),
                 icon("right angle divider"),
                 a(class="section", "Store"),
                 icon("right angle divider"),
                 a(class="section", "T-shirts"))),
        demo(div(class="ui huge breadcrumb",
                 a(class="section", "Home"),
                 icon("right angle divider"),
                 a(class="section", "Store"),
                 icon("right angle divider"),
                 a(class="section", "T-shirts")))
    )
}
accordion_demo <- function() {
    accordion_content <- list(
        list(title = "What is dog?",
             content = p("A dog is a type of domesticated animal.
                     Known for its loyalty and faithfulness,
                     it can be found as a welcome guest in many
                     households across the world.")),
        list(title = "What kinds of dogs are there?",
             content = p("There are many breeds of dogs. Each breed varies
                      in size and temperament. Owners often select a breed of
                      dog that they find to be compatible with their own lifestyle
                      and desires from a companion."))
    )
    div(
        h1(class="ui header", id="accordion", "Accordion"),
        demo(
            accordion(accordion_content, fluid = F, active_title = "What is dog?",
                      custom_style = "background: #fffddb;")
        )
    )
}
grid_demo <- function() {
    div(
        h1(class="ui header", id="grid", "Grid"),
        demo(
            grid(grid_template(default = list(
                areas = rbind(
                    c("header", "header", "header"),
                    c("menu",   "main",   "right1"),
                    c("menu",   "main",   "right2")
                ),
                rows_height = c("50px", "auto", "100px"),
                cols_width = c("100px", "2fr", "1fr")
            )),
            container_style = "border: 5px solid #3d7ea6",
            area_styles = list(header = "border-bottom: 3px solid #5c969e",
                               menu = "border-right: 3px solid #5c969e",
                               main = "border-right: 3px solid #5c969e",
                               right1 = "border-bottom: 3px solid #5c969e"),
            header = div("header"),
            menu = div("menu"),
            main = grid(grid_template(default = list(
                areas = rbind(
                    c("top_left", "top_right"),
                    c("bottom_left", "bottom_right")
                ),
                rows_height = c("50%", "50%"),
                cols_width = c("50%", "50%")
            )),
            container_style = "padding: 5px;",
            area_styles = list(top_left = "border: 3px solid #ffa5a5;",
                               top_right = "border: 3px solid #ffa5a5;",
                               bottom_left = "border: 3px solid #ffa5a5;",
                               bottom_right = "border: 3px solid #ffa5a5;"),
            top_left = div("main top left"),
            top_right = div("main top right"),
            bottom_left = div("main bottom left"),
            bottom_right = div("main bottom right")
            ),
            right1 = div("right 1"),
            right2 = div("right 2")
            )
        )
    )
}
card_demo <- function() {
    div(
        h1(class="ui header", id="card", "Card"),
        demo(
            card(
                div(class="content",
                    div(class="header", "Elliot Fu"),
                    div(class="meta", "Friend"),
                    div(class="description", "Elliot Fu is a film-maker from New York.")
                )
            )
        ),
        demo(
            cards(
                class = "three",
                mtcars %>% tibble::rownames_to_column() %>% head %>%
                    purrrlyr::by_row(~ {
                        card(
                            div(class="content",
                                div(class="header", .$rowname),
                                div(class="meta", paste("Number of cylinders:", .$cyl)),
                                div(class="description", paste("1/4 mile time:", .$qsec))
                            )
                        )
                    }) %>% {.$.out}
            )
        ),
        demo(
            card(
                div(class="content",
                    div(class="header", "Elliot Fu"),
                    div(class="meta", "Friend"),
                    div(class="description", "Elliot Fu is a film-maker from New York.")
                )
            )
        ),
        demo(
            div(class="ui card",
                div(class="content",
                    div(class="right floated meta", "14h"),
                    img(class="ui avatar image", src="images/elliot.jpg"),
                    "Elliot"
                ),
                div(class="image", img(src="images/wireframe.png")),
                div(class="content",
                    span(class="right floated", icon("heart outline like"), "17 likes"),
                    icon("comment"),
                    "3 comments"
                ),
                div(class="extra content",
                    div(class="ui large transparent left icon input",
                        icon("heart ouline"),
                        tags$input(type="text", placeholder ="Add Comment...")
                    )
                )
            )
        )
    )
}

msgbox_demo <- function() {
    div(
        h1(class="ui header", id="messagebox", "Messagebox"),
        demo(message_box(header = "Main header", content = "text")),
        demo(message_box(class = "icon", header = "Main header", content = "text", icon_name = "dog")),
        demo(message_box(header = "Main header", content = "text", closable =  TRUE)),
        demo(message_box(class = "floating", header = "Main header", content = "text")),
        demo(message_box(class = "compact", header = "Main header", content = "text")),
        demo(message_box(class = "warning", header = "Warning", content = "text")),
        demo(message_box(class = "info", header = "Info", content = "text"))
    )
}

uilabel <- function() {
    div(
        h1(class="ui header", id="label", "Label"),
        demo(h1(class="ui header", "First header"))
    )
}

rating <- function() {
    div(
        h1(class="ui header", id="rating", "Rating"),
        demo(rating_input(
            input_id = "rating_example",
            label = "",
            value = 0,
            max = 3,
            icon = "star",
            color = "yellow",
            size = ""
        )
        ))
}

slider_demo <- function() {
    div(
        h1(class="ui header", id="slider", "Slider"),
        demo(slider_input("slider_1", value = 10, min = 0, max = 20)),
        demo(range_input("range_1", value = 10, value2 = 15, min = 0, max = 20))
    )
}

checkbox <- function() {
    div(
        h1(class="ui header", id="checkbox", "Checkbox"),
        demo(checkbox_input("example", "Check me", is_marked = FALSE)),
        demo(toggle("tog1", "My Label", TRUE))
    )
}

progress_demo <- function() {
    div(
        h1(class="ui header", id="progress", "Progress"),
        demo(progress("progress", percent = 24, label = "{percent}% complete"))
    )
}

tabs <- function () {
    div(
        h1(class="ui header", id="tabset", "Tabset"),
        demo(
            tabset(list(
                list(menu = div("First link"), content = div("First content")),
                list(menu = div("Second link"), content = div("Second content")),
                list(menu = div("Third link"), content = div("Third content"))
            ))
        )
    )
}

menu_demo <- function() {
    div(
        h1(class="ui dividing header", id = "menu", "Menu"),
        demo(menu(
            menu_item("Home"),
            menu_item("Tab 1")
        )),
        demo(menu(
            menu_item("Home"),
            menu_item("Tab 1"),
            class = "vertical"
        )),
        demo(horizontal_menu(list(
            list(name = "AA", link = "http://example.com", icon = "dog"),
            list(name = "BB", link = "#", icon="cat"),
            list(name = "CC")
        ))),
        demo(menu(menu_item("Menu"),
                  dropdown_menu(
                      "Action",
                      menu(
                          menu_header(icon("file"), "File", is_item = FALSE),
                          menu_item(icon("wrench"), "Open"),
                          menu_item(icon("upload"), "Upload"),
                          menu_item(icon("remove"), "Upload"),
                          menu_divider(),
                          menu_header(icon("user"), "User", is_item = FALSE),
                          menu_item(icon("add user"), "Add"),
                          menu_item(icon("remove user"), "Remove")),
                      class = "",
                      name = "unique_name",
                      is_menu_item = TRUE)
        ))
    )
}

list_demo <- function() {
    div(
        h1(class="ui dividing header", id = "list", "List"),
        demo(list_container(list(
            list(header = "Head 1", description = "Lorem ipsum", icon = "home"),
            list(header = "Head 2", description = "Lorem ipsum", icon = "dog"),
            list(header = "Head 3", description = "Lorem ipsum", icon = "sun")
        ), is_divided = FALSE)),
        demo(list_container(list(
            list(header = "Head 1", description = "Lorem ipsum", icon = "home"),
            list(header = "Head 2", description = "Lorem ipsum", icon = "dog"),
            list(header = "Head 3", description = "Lorem ipsum", icon = "sun")
        ), is_divided = TRUE))
    )
}

section <- function() {
    div(
        h1(class="ui dividing header", id="section", "Section"),
        demo(h1(class="ui header", "First header"))
    )
}

sidebar <- function() {
    div(class="ui sidebar inverted vertical visible menu",
        div(class="item",
            div(class="active header", "Elements"),
            div(class="menu",
                a(class="item", href="#header", "Header"),
                a(class="item", href="#divider", "Divider"),
                a(class="item", href="#input", "Input"),
                a(class="item", href="#label", "Label"),
                a(class="item", href="#menu", "Menu"),
                a(class="item", href="#list", "List"),
                a(class="item", href="#button", "Button"),
                a(class="item", href="#icon", "Icon"))),
        div(class="item",
            div(class="active header", "Collections"),
            div(class="menu",
                a(class="item", href="#grid", "Grid"),
                a(class="item", href="#breadcrumb", "Breadcrumb"))),
        div(class="item",
            div(class="active header", "Views"),
            div(class="menu",
                a(class="item", href="#card", "Card"))),
        div(class="item",
            div(class="active header", "Modules"),
            div(class="menu",
                a(class="item", href="#accordion", "Accordion"),
                a(class="item", href="#rating", "Rating"),
                a(class="item", href="#slider", "Slider"),
                a(class="item", href="#checkbox", "Checkbox"),
                a(class="item", href="#progress", "Progress"),
                a(class="item", href="#messagebox", "Messagebox"),
                a(class="item", href="#tabset", "Tabset"),
                a(class="item", href="#notification", "Notification"),
                a(class="item", href="#calendar", "Calendar")
            )))
}

calendar_demo <- function() {
    div(
        h1(class="ui header", id="calendar", "Calendar"),
        demo(
            calendar("date", type = "date", value = "2020-02-20", placeholder = "Select Date",
                     min = "2020-02-02", max = "2020-02-25")
        ),
        demo(
            calendar("month", type = "month", placeholder = "Pick Month")
        )
    )
}


css <- "
#examples > div > .header {
  margin-top: 1em;
}
.theme.form {
  position: fixed !important;
  right: 5px;
  top: 3px;
  width: 15em !important;
}"

ui <- function() {
    shinyUI(semanticPage(
        tags$head(tags$style(HTML(css))),
        useShinyjs(),
        sidebar(),
        div(style="margin-left: 210px",
            div(id="examples", class="ui container",
                header(),
                button(),
                counter_button_demo(),
                icon_demo(),
                step_demo(),
                divider(),
                uiinput_demo(),
                uilabel(),
                menu_demo(),
                list_demo(),
                grid_demo(),
                breadcrumb(),
                card_demo(),
                accordion_demo(),
                slider_demo(),
                rating(),
                checkbox(),
                progress_demo(),
                msgbox_demo(),
                toast_demo(),
                tabs(),
                calendar_demo(),
                br(),br()
            )
        )
    ))
}

server <- shinyServer(function(input, output, session) {
    runjs(jsCode)
    
    observeEvent(input$show_toast, {
        toast(
            "This is a semantic toast. Cheers!",
            title  = "Notification",
            duration = 3,
            session = session
        )
    })
})

shinyApp(ui = ui(), server = server)
