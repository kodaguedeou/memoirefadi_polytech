#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(bslib)  #bootrap theme customizations

#page theme

page_theme <- bs_theme(
  # Controls the default grayscale palette
  bg = "#202123", fg = "#B8BCC2",
  # Controls the accent (e.g., hyperlink, button, etc) colors
  primary = "#EA80FC", secondary = "#48DAC6",
  base_font = c("Grandstander", "sans-serif"),
  code_font = c("Courier", "monospace"),
  heading_font = "'Helvetica Neue', Helvetica, sans-serif",
  # Can also add lower-level customization
  "input-border-color" = "#EA80FC"
)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Poverty determinants evaluation"),
    lang = "fr-FR",
    theme = page_theme,

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            radioButtons("sexe",
                         "Your sex",
                         choices = c("Male", "Female"),
                         #choiceNames = c("Male", "Female"),
                         ),
            numericInput("age",
                         "Your age",
                         value=21,
                         min = 1,
                         max = 200
                         ),
            sliderInput("taillemenage",
                        "Household size",
                        min = 1,
                        max = 200,
                        value = 3
                        ),
            selectInput("education",
                        "Educational attainment",
                        choices = c("No education, preschool","Secondary","Primary","Higher","Don't know")
                        ),
            
            sliderInput("nbadulte",
                        "Number of Adults in your household",
                        min = 1,
                        max = 200,
                        value = 3
                        ),
            selectInput("region",
                        "Region of residence",
                        choices = c("Far-North","East","Centre (without Yaounde)","Yaounde","Adamawa","North-West","Littoral (without Douala)","Douala","South","West","South-West","North")
                        )
            
            
            
        ),

        # Show a plot of the generated distribution
        mainPanel(
            #textOutput("testerOne"),
            #textOutput("predictionResults"),
            tableOutput("predProbs"),
            textOutput("predClass")
        )
    )
)
