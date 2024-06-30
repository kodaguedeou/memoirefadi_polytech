#Shiny app entry point
library(shiny)
require("shiny_app/ui.R")
require("shiny_app/server.R")



shinyApp(ui, server = server)