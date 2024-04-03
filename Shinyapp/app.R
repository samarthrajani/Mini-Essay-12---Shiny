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
library(readr)
library(ggplot2)
library(DT)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Graph of Aushwitz victims by Birthplace"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput("Birthplace",
                  "Select Birthplace:",
                  choices = c("Warschau","Amsterdam","Litzmannstadt","Krakau", "Berlin","Paris","Wien"),
                  multiple = TRUE)  # Allow multiple selection
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("victim_plot"),
      DT::dataTableOutput("table")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  # Get data
  data <- data.frame(read_csv("~/Mini-Essay-12---Shiny/Auschwitz_Death_Certificates_1942-1943 - Auschwitz.csv"))
  Birthplace_counts <- table(data$Birthplace)
  Birthplace_counts_dataframe <- as.data.frame(Birthplace_counts)
  names(Birthplace_counts_dataframe) <- c("Birthplace", "Count")
  
  # Draw interactive plot
  
  output$victim_plot <- renderPlot({
    req(input$Birthplace)
    filtered_df <- filter(Birthplace_counts_dataframe, Birthplace %in% input$Birthplace)
    ggplot(filtered_df, aes(x = Birthplace, y = Count, fill = Birthplace)) +
      geom_bar(stat = "identity") +
      labs(
        title = "Holocaust Victims by Birthplace",
        x = "Birthplace",
        y = "Count"
      ) 
  })
  
  # Render interactive table
  output$table <- DT::renderDataTable({
    req(input$Birthplace)
    filtered_df <- filter(Birthplace_counts_dataframe, Birthplace %in% input$Birthplace)
    filtered_df
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

