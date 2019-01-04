# More-Honey Final Project Details

## Overview

In this application, we will be looking at honey production data from **1998 to 2012**. This data was obtained from [kaggle.com](kaggle.com), and was read in by *CSV*.

## Getting Started

Please note that you will have to install the dev version of Plotly for one of our plots to work. You can install it by running this line: 
```install.packages(devtools::install_github("ropensci/plotly"))```

## Main Functions

### Honey Production by Year

Select a state to see the honey production for that state graphed over time. Select either **Total Production** , **Production Value** , or **both** to see the data for total production, production value, or both together


```
sidebarLayout(
    sidebarPanel(
        # Input for State
        selectInput("state_input",
        label = h3("State"),
        choices = c("Display all" = "all states", 
                    distinct(honeyproduction, state))
        ),
        # Input for type of production
        selectInput("prod",
        label = h3("Included Lines"),
        choices = list(
            "Total Production" = "totalprod",
            "Production Value" = "price",
            "Both" = "all"
        )
    )
)
```

![image](https://user-images.githubusercontent.com/32496771/50683023-896b5f00-0fc5-11e9-9909-8b385182c764.png)


### National Averages by Year

Select a data type to see the national average for that data type over time. Select a plot type to see the data plotted in different ways.

```
sidebarLayout(
    sidebarPanel(

        # Input for data type
        selectInput("col_input",
        label = h3("Data Type"),
        choices = list(
            "Number of Colonies",
            "Yield per Colony",
            "Total Production",
            "Price/Pound",
            "Production Value"
        )
        ),

        # Input for chart type
        radioButtons(
        inputId = "chart_type",
        label = "Plot Type",
        choices = c(
            "Barplot" = "bar",
            "Boxplot" = "box",
            "Quantile" = "quant",
            "Violin" = "violin"
        )
        )
    ),

    # Displays plot
    mainPanel(
        plotlyOutput("national_yearly_prod")
    )
)
```
![image](https://user-images.githubusercontent.com/32496771/50683102-c5062900-0fc5-11e9-83ee-13ec315230d7.png)

### Analysis

An analysis of the honey production according to graphs generated.

### Sorted Raw Data

Select a **year** to see the raw data from that year or select **Display all** to see all of the data. Click on a column to sort by that column or use the search bar to find a specific data entry.

![image](https://user-images.githubusercontent.com/32496771/50683170-fed72f80-0fc5-11e9-96c7-4db11875bc5c.png)



## Website 
Here is a link to our final project: https://wangw05.shinyapps.io/more-honey/ 

## Authors
* **Yiran Ni** 
* **Richie Wang** 
* **Jacky Chien**
* **Justine Leonard**  

## Project Period

Mar 2018 - June 2018
