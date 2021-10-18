
# shinycookie

<!-- badges: start -->
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/mikmart/shinycookie/workflows/R-CMD-check/badge.svg)](https://github.com/mikmart/shinycookie/actions)
<!-- badges: end -->

The goal of shinycookie is to let you interact with JavaScript cookies on the client from your Shiny server function without writing JavaScript. On the JavaScript side, interacting with cookies is handled with the [JavaScript Cookie](https://github.com/js-cookie/js-cookie) library.

## Installation

shinycookie is not on CRAN. You can install the development version with:

``` r
remotes::install_github("mikmart/shinycookie")
```

## Example

Here's a simple app showcasing different interactions with cookies:

``` r
library(shiny)
library(shinycookie)

ui <- fluidPage(
  useShinycookie(),
  textInput("cookie_name", "Cookie name:"),
  textInput("cookie_value", "Cookie value:"),
  actionButton("set", "Set"),
  actionButton("get", "Get"),
  actionButton("remove", "Remove"),
  verbatimTextOutput("cookie"),
)

server <- function(input, output, session) {
  observeEvent(input$get, cookies_get("cookie", input$cookie_name))
  
  observeEvent(input$set, {
    cookies_set(input$cookie_name, input$cookie_value)
    updateTextInput(inputId = "cookie_name", value = "")
    updateTextInput(inputId = "cookie_value", value = "")
    cookies_get("cookie", input$cookie_name)
  })
  
  observeEvent(input$remove, {
    cookies_remove(input$cookie_name)
    cookies_get("cookie", input$cookie_name)
  })
  
  output$cookie <- renderPrint(input$cookie)
}

shinyApp(ui, server)
```
