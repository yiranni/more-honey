library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)
library(graphics)
source("scripts/state_yearly_prod.R")
source("scripts/national_yearly_prod.R")

# Our dataset!
honeyproduction <-
  read.csv("./data/honeyproduction.csv", stringsAsFactors = FALSE)

shinyServer(function(input, output) {
  
  # Raw Data Table
  output$table <- renderDataTable({
    honeyproduction <- rename(honeyproduction,
      "State" = state, "Number of Colonies" = numcol,
      "Yield/Colony" = yieldpercol,
      "Total Production" = totalprod, "Stocks" = stocks,
      "Price/lb " = priceperlb, "Production Value" = prodvalue, "Year" = year
    )
    
    if (input$selectedYear == "all") {
      year_filter <- honeyproduction
    } else {
      year_filter <-
        subset(honeyproduction, honeyproduction$Year == input$selectedYear)
    }
  })

  # Honey Production by Year plot
  output$state_yearly_prod <- renderPlotly({
    return(state_prod(honeyproduction, input$state_input, input$prod))
  })

  # National Averages plot
  output$national_yearly_prod <- renderPlotly({
    return(national_yearly_prod(
      honeyproduction,
      input$col_input, input$chart_type
    ))
  })
})
