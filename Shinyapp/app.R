#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(dplyr)
dataset <- data.frame(read.csv('/Users/Samarthsumitrajani/Downloads/Auschwitz_Death_Certificates_1942-1943 - Auschwitz.csv'))
# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Graph of Aushwitz victims byBirthplace"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            selectInput("Birthplace",
                        "Select Birthplace:",
                        choices = c("Warschau","Amsterdam","Litzmannstadt","Krakau", "Berlin","Paris","Wien"))
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("victim_plot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    # Get data
  data <- data.frame(read.csv('/Users/Samarthsumitrajani/Downloads/Auschwitz_Death_Certificates_1942-1943 - Auschwitz.csv'))
 Birthplace_counts <- table(data$Birthplace)
 Birthplace_counts_dataframe <- as.data.frame(Birthplace_counts)
  names(Birthplace_counts_dataframe) <- c("Birthplace", "Count")
  
  # Filter this data based on user's input
  
  filtered_data <- reactive({
    req(input$Birthplace)
    filtered_df <- filter( Birthplace_counts_dataframe, Birthplace == input$Birthplace)
    filtered_df
  })
  
  # Draw interactive plot
  
  output$victim_plot <- renderPlot({barplot(filtered_data()$Count)}, 
                                   names.arg = filtered_data()$Birthplace,
                                   main = "Holocaust Victims by Birthplace",
                                   xlab = "Birthplace",
                                   ylab = "Count",
                                   col = "green")
  
}

# Run the application 
shinyApp(ui = ui, server = server)
