library(plotly)
library(dplyr)
# Defining helper methods

add_prod <- function(plot) {
  plot <- add_trace(plot,
    x = ~ year, y = ~ totalprod,
    type = "scatter", mode = "lines",
    name = "Total Production (lbs)",
    hoverinfo = "text",
    text = ~ paste0(
      "Year: ", year,
      "<br>Total Production: ",
      totalprod, " lbs."
    )
  )
  plot
}

add_val <- function(plot) {
  plot <- add_trace(plot,
    x = ~ year, y = ~ prodvalue,
    type = "scatter", mode = "lines",
    name = "Total Production Value (Dollars)",
    hoverinfo = "text",
    text = ~ paste0(
      "Year: ", year,
      "<br>Price per Pound: $", priceperlb,
      "<br>Total Production Value: $", prodvalue
    )
  )
  plot
}

# Function to return state yearly honey production
state_prod <- function(df, sta, prod) {
  # Filtering data to only one state
  if (sta == "all states") {
    df <- df %>% group_by(year) %>%
          summarise(totalprod = sum(totalprod), 
                    prodvalue = sum(prodvalue), 
                    priceperlb = sum(priceperlb))
  } else {
    df <- df %>% filter(state == sta)
  }

  # Generate empty Plotly
  p <- plot_ly(df, type = "scatter", mode = "lines") %>%
    layout(
      xaxis = list(title = "Year"), yaxis = list(title = "Count"),
      title = paste0("Honey Production by year in ", sta)
    )

  # Filtering data for prod, stock, or both
  if (prod == "all") {
    df <- df %>% select(totalprod, prodvalue, year)
    p <- add_prod(p)
    p <- add_val(p)
  } else if (prod == "price") {
    df <- df %>% select(prodvalue, year)
    p <- add_val(p)
  } else {
    df <- df %>% select(prodvalue, year)
    p <- add_prod(p)
  }

  p
}
