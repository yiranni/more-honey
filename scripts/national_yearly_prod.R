library(plotly)
library(dplyr)
library(RColorBrewer)
# install.packages(devtools::install_github("ropensci/plotly"))

# Generate input dataframe for colnames
names_df <- data.frame(c(
  "Number of Colonies",
  "Yield per Colony",
  "Total Production",
  "Price/Pound",
  "Production Value"
),
c(
  "numcol",
  "yieldpercol",
  "totalprod",
  "priceperlb",
  "prodvalue"
),
stringsAsFactors = FALSE
)

colnames(names_df) <- c("actual", "column")

# Support function for cleaning data
clean_data <- function(df, yaxis, chart_type) {

  # Calculating yearly avgs, and making new df
  if (chart_type == "bar") {
    df <- df %>%
      select(-state) %>%
      group_by(year) %>%
      summarise_all(mean)
  }

  df2 <- df %>% select(year, yaxis)

  colnames(df2) <- c("year", "yax")

  return(df2)
}

# Generating plot - function
national_yearly_prod <- function(df, yaxis_actual, chart_type) {
  # Convert actual axis wording to column wording
  yaxis <- names_df[names_df$actual == yaxis_actual, "column"]

  # Clean data for creating plot
  df <- clean_data(df, yaxis, chart_type)

  # Generating Plotly with bar
  if (chart_type == "bar") {
    p <- plot_ly(df,
      x = ~ year, y = ~ yax, type = "bar",
      colors = "Accent", color = ~ year, hoverinfo = "text",
      text = ~ paste0(
        "Year: ", year,
        "<br>", yaxis_actual, ": ",
        round(yax, digits = 2)
      )
    ) %>%
      layout(
        title = paste0(
          "National averages for ",
          yaxis_actual, " by year"
        ),
        yaxis = list(title = yaxis_actual),
        xaxis = list(title = "Year")
      )
    p
  } else if (chart_type == "box") {
    p <- plot_ly(df,
      x = ~ year, y = ~ yax, type = "box",
      colors = "Accent", color = ~ year
    ) %>%
      layout(
        title = paste0(
          "National averages for ",
          yaxis_actual, " by year"
        ),
        yaxis = list(title = yaxis_actual),
        xaxis = list(title = "Year")
      )
    p
  } else if (chart_type == "quant") {
    ggplotly(qplot(year, yax,
      data = df,
      xlab = "Year", ylab = yaxis_actual,
      geom = c("point", "smooth"), col = year
    ))
  } else if (chart_type == "violin") {
    p <- plot_ly(df,
      x = ~ year, y = ~ yax, split = ~ year,
      type = "violin", box = list(visible = T),
      meanline = list(visible = T)
    ) %>%
      layout(
        xaxis = list(title = "Year"),
        yaxis = list(title = yaxis_actual),
        title = paste0(
          "National averages for ",
          yaxis_actual, " by year"
        )
      )
    p
  } else {

  }
}
