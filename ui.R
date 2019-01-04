library(shiny)
library(plotly)
library(shinythemes)
library(dplyr)
library(graphics)

honeyproduction <-
  read.csv("./data/honeyproduction.csv", stringsAsFactors = FALSE)

shinyUI(navbarPage(
  theme = "custom.css",
  "Honey Production in the U.S.",
  id = "navbar",

  # About tab
  tabPanel(
    "About",
    headerPanel(
      h1("About", align = "center")
    ),
    br(),
    br(),
    br(),
    br(),
    mainPanel(

      # Paragraphs describing the dataset
      p(
        "In this project, we have utilized the dataset from",
        url <- a("Honey Production in the USA",
          href =
            "https://www.kaggle.com/jessicali9530/honey-production/data"
        ), ".",
        "This dataset shows honey production numbers
        and prices by state from 1998 to 2012.
          The data was collected by the",
        strong("National Agricultural Statistics Service
               (NASS) of the U.S. Department of Agriculture"),
        "and we accessed it using", url <- a("kaggle.com",
          href = "https://www.kaggle.com/"
        ),
        "."
      ),
      p(
        "Our possible audiences are bee",
        strong("farmers"), ", ", strong("researchers"),
        ", ", strong("people who work in the honey industry"),
        ", ", "and anyone who might be affected by the rapid
        decline in honeybee population in 2006,
          which had lasting effects on the honey
        industry to this day.
          Our target audience is stores and parties
        that buy honey from the honey farmers
          and then resell it as this data will be most useful for them."
      ),

      # Page Descriptions
      p("The", strong("\"Honey Production by Year\""), "page allows users
        to select a state and either the total production, production 
        value, or both, and see the selected data graphed by year.  
        The", strong("\"National Averages by Year\""), "page allows users 
        to select a data type and type of plot and graphs
        the national averages of the selected data type by year."),
      p(
        "The", strong("\"Analysis\""), "page includes an in depth analysis 
        of the data displayed in both the", strong("\"Honey Production by 
        Year\""), "page, and the", strong("\"National Averages by Year\""),
        "page, relating the data to real-life trends and news in the U.S. 
        honey industry.  Finally, the", strong("\"Raw Data\""), "page 
        allows the ability to find and view the entire raw dataset we used 
        from 1998 to 2012."
      ),
      width = 12
    ),

    # Our Team section
    headerPanel(
      h1("Our Team", align = "center")
    ),
    mainPanel(
      br(),
      img(src = "group-photo.png"),
      style = "margin-left:180px"
    )
  ),

  # Honey Production by Year Interactive Plot tab
  tabPanel(
    "Honey Production by Year",
    div(
      class = "myContent",
      
      # Title and Description
      headerPanel(
        h1("Honey Production by Year", align = "center")
      ),
      br(),
      p("Select a state to see the honey production for that state
        graphed over time.  Select either ", em("Total Production"), ",",
        em("Production Value"), ", or both to see the data for total
        production, production value, or both together."),
      br(),
      
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
        ),

        # Displays Plot
        mainPanel(
          plotlyOutput("state_yearly_prod")
        )
      )
    )
  ),

  # National Averages by Year Interactive Plot tab
  tabPanel(
    "National Averages by Year",
    div(
      class = "myContent",
      
      # Title and Description
      headerPanel(
        h1("National Averages by Year", align = "center")
      ),
      br(),
      p("Select a data type to see the national average for that data
        type over time.  Select a plot type to see the data plotted
        in different ways."),
      br(),
      
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
    )
  ),


  # Analysis tab
  tabPanel(
    "Analysis",
    headerPanel(
      h1("Data Analysis", align = "center")
    ),
    mainPanel(

      # General Information
      p("This dataset a visualized way to understand the trend
        of US honey production throughout years."),
      p("In the ", strong("Honey Production by Year"), " plot, users are able
        to select and see the Total Production and Production Value of each 
        state. Analyzing this interactive graph, we found that the Total 
        Production is decreasing over time while the Production Value is 
        increasing from 1998 to 2012 in general. The following graph 
        illustrates this comparison of Total Production and Production Value 
        totaled for all states. To see this comparison for individual states,
        go to the ", strong("Honey Production by Year"), "tab."),

      # Florida total production vs. production value chart
      img(
        width = 1000, height = 500, src = "total-honey-production.png",
        style = "margin-left:180px"
      ),
      p("In the ", strong("National Averages by Year"), " plot, we take the 
        average number of each variable from every state and provide 5 
        national average variables related to honey production- 
        Number of Colonies, Yield per Colony,
        Total Production, Price/Pound, and Production Value."),
      p("According to the graph, there is not too much change for
        the nuumber of colonies through the years."),

      # Number of colonies chart
      img(
        width = 1000, height = 500, src = "number-of-colonies.png",
        style = "margin-left:180px"
      ),
      p(
        "Compare this to the decrease of yield per colony and total production,
        where the average total production experiences a much greater 
        decrease from 1998 to 2012. This shows that despite no decrease in 
        the number of be colonies in the United States, there has been a 
        significant decrease in the total yield of honey. This explains the 
        huge increase in demand, especially from fruit, nut, and vegetable 
        growers, who need the bees to pollinate their crops. One example of
        this is ", a("almond growers",
          href =
            "https://s.giannini.ucop.edu/uploads/giannini_public/cb/7c/cb7c1177-c7d2-44df-a5a8-8aad2f3ed858/v14n5_4.pdf"
        ),
        ", who are spending an additional $83 million a year on pollination,
        causing an increase in almond prices. Therefore, you can see that the 
        bee industry has a cascading effect on the prices of other crops that
        depend on their pollination."
      ),

      # Yield per colony and total production charts
      div(
        img(
          width = 500, height = 250, src = "yield-colony.png",
          style = "display:inline-block"
        ),
        img(
          width = 500, height = 250, src = "total-production.png",
          style = "display:inline-block"
        ),
        style = "text-align:center"
      ),
      p("Along with the demand hike comes an increase in price per pound and 
        production value, as displayed by the below graphs.  This data
        explains why honey is becoming more expensive for retail stores who
        buy the honey from farmers and farming companies."),

      # Price per pound and production value charts
      div(
        img(
          width = 500, height = 250, src = "price-pound.png",
          style = "display:inline-block"
        ),
        img(
          width = 500, height = 250, src = "production-value.png",
          style = "display:inline-block"
        ),
        style = "text-align:center"
      ),

      # Further analysis on Colony Collapse Disorder
      p(
        "Something these retailers might want to know is ", em("why"),
        "they are experiencing these price hikes.  From the data you can see
        that bee colonies are experiencing less yeild per colony despite a
        relatively constant total number of colonies. This decrease in yeild
        comes from what's called ", em("Colony Collapse Disorder"), "."
      ),
      p(
        a("Colony Collapse Disorder",
          href = "https://fas.org/sgp/crs/misc/RL33938.pdf"
        ),
        " is essentially when bees leave the hive to find food and don't
        come back, causing the remaining hive to collapse. Researchers
        aren't sure where this disorder comes from but they believe
        insecticides are at least partially to blame. Our data shows
        the drastic effect this has had on the industry and ",
        a("additional research",
          href =
            "https://www.nytimes.com/2017/02/16/business/a-bee-mogul-confronts-the-crisis-in-his-field.html"
        ),
        "shows the cost this has had on the industry and the entire
        U.S. farming industry."
      ),

      # Governmental Action on CCD
      p("Global concern over this collapse started in 2006 when these
        prices experienced the greatest increase. It took a long time
        for action to be taken, but in 2014, President Obama created
        a", strong("Bee and Pollinator Task Force"), "to study and
        find solutions to bee colony collapses.  The EPA prohibited 
        approval of any use of unapproved neonicotinoid pesticides
        to try and prevent further bee colony collapse.  However,
        the government has been slow to respond and has yet to find a
        solution. Some industries are still recovering from the most
        extreme collapse over 12 years ago, and the U.S. honey industry
        is still largely struggling as the U.S. now looks to import
        much of its honey from overseas."),
      width = 12
    )
  ),

  # Raw Data tab
  tabPanel(
    "Raw Data",
    div(
      class = "myContent",
      
      # Title and Description
      headerPanel(
        h1("Raw Data", align = "center")
      ),
      br(),
      p("Select a year to see the raw data from that year or select ",
        em("Display all"), "to see all of the data.  Click on a column
        to sort by that column or use the search bar to find a specific
        data entry."),
      br(),
      
      # Data Table
      sidebarLayout(
        sidebarPanel(
          selectInput("selectedYear",
            label = "Year:",
            choices = c("Display all" = "all", honeyproduction$year),
            selected = "all"
          )
        ),

        mainPanel(
          dataTableOutput("table")
        )
      )
    )
  )
))
