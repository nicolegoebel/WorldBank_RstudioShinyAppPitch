library(shiny)
library(httpuv)

shinyUI(pageWithSidebar(
  headerPanel("Global Temperature"),
  
  sidebarPanel(
    checkboxGroupInput("scen1", label = h3("Select 1 Map #1 Scenario"), 
                       choices = list("pre-2000" = "past", "post-2000: 850 ppm by 2100 (a2)"="a2","post-2000: 550 ppm by 2100 (b1)"="b1"), selected = "past"),
    conditionalPanel(condition = "input.scen1 == 'past'",
                     selectInput("yearspred1a", "Select Map #1 Years Hindcasted",choices = list("1920-1939", "1940-1959", "1960-1979", "1980-1999"))),
    conditionalPanel(condition = "input.scen1 == 'a2'",
                     selectInput("yearspred1b", "Select Map #1 Years Predicted",choices = list("2020-2039", "2040-2059","2060-2079", "2080-2099"))),
    conditionalPanel(condition = "input.scen1 == 'b1'", 
                     selectInput("yearspred1c", "Select Map #1 Years Predicted",choices = list("2020-2039", "2040-2059", "2060-2079", "2080-2099")))
  ),
  mainPanel(
    h3(textOutput("add1")),
    imageOutput("plot1")
  )  
)
)