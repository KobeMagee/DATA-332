library(readxl)
library(ggplot2)
library(rsconnect)
library(shiny)
library(DT)
library(dplyr)
library(lubridate)
library(leaflet)
library(leaflet.extras)
library(reshape2)

#setwd("C:/Users/kobem/Documents/GitHub/DATA-332/Uber Assignment")
df_apr <- read.csv('uber-raw-data-apr14.csv')
df_may <- read.csv('uber-raw-data-may14.csv')
df_jun <- read.csv('uber-raw-data-jun14.csv')
df_jul <- read.csv('uber-raw-data-jul14.csv')
df_aug <- read.csv('uber-raw-data-aug14.csv')
df_sep <- read.csv('uber-raw-data-sep14.csv')

# Step 1: Bind all the data together
combined_df <- rbind(df_apr, df_may, df_jun, df_jul, df_aug, df_sep)

# Step 2: Changing the date column to a date schema
combined_df$Date <- as.Date(combined_df$Date.Time, format = "%m/%d/%Y")

# Convert Date.Time to POSIXct format with the appropriate format
combined_df$Date.Time <- as.POSIXct(combined_df$Date.Time, format = "%m/%d/%Y %H:%M:%S")

# Extract hour from Date.Time column
combined_df$Hour <- as.POSIXlt(combined_df$Date.Time)$hour

# Extract month from Date.Time column
combined_df$Month <- as.numeric(format(combined_df$Date.Time, "%m"))

# Create pivot table to display trips by hour and month
pivot_table_month_hour <- combined_df %>%
  group_by(Month, Hour) %>%
  summarise(Trips = n())

# Extract day from Date.Time column
combined_df$Day <- as.numeric(format(combined_df$Date.Time, "%d"))

# Extract month and day of the week from Date.Time column
combined_df$Month <- format(combined_df$Date.Time, "%B")
combined_df$DayOfWeek <- factor(weekdays(combined_df$Date.Time), levels = c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"))

# Create pivot table to display trips by month and day of the week
pivot_table_month_day_of_week <- combined_df %>%
  group_by(Month, DayOfWeek) %>%
  summarise(Trips = n())

# Create pivot table to display trips by base and month
pivot_table_base_month <- combined_df %>%
  group_by(Base, Month) %>%
  summarise(Trips = n())

# Create pivot table for hour and day
pivot_table_hour_day <- combined_df %>%
  group_by(Hour, DayOfWeek) %>%
  summarise(Trips = n())

# Create pivot table to display trips by hour and day
pivot_table_hour_day <- combined_df %>%
  group_by(Hour, DayOfWeek) %>%
  summarise(Trips = n())

# Create pivot table to display trips by month and day
pivot_table_month_day <- combined_df %>%
  group_by(Month, Day) %>%
  summarise(Trips = n())

# Function to define week number within each month
get_week <- function(day) {
  week_num <- ceiling(day / 7)
  paste0("Week ", week_num)
}

# Create pivot table to display trips by month and week
pivot_table_month_week <- combined_df %>%
  mutate(Week = get_week(Day)) %>%
  group_by(Month, Week) %>%
  summarise(Trips = n())

# Create pivot table to display trips by bases and day of the week
pivot_table_bases_day <- combined_df %>%
  group_by(Base, DayOfWeek) %>%
  summarise(Trips = n())

#Shiny
# Define UI
ui <- fluidPage(
  titlePanel("Uber Data Analysis"),
  
  # Define tabs
  tabsetPanel(
    tabPanel("Trips by Hour and Month",
             verbatimTextOutput("month_hour_description"),
             plotOutput("month_hour_plot")),
    tabPanel("Trips by Day and Month",
             verbatimTextOutput("month_day_description"),
             plotOutput("month_day_plot")),
    tabPanel("Trips by Base and Month",
             verbatimTextOutput("base_month_description"),
             plotOutput("base_month_plot")),
    tabPanel("Heat Map by Hour and Day",
             plotOutput("hour_day_heatmap")),
    tabPanel("Heat Map by Month and Day",
             plotOutput("month_day_heatmap")),
    tabPanel("Heat Map by Month and Week",
             plotOutput("month_week_heatmap")),
    tabPanel("Heat Map Bases and Day of Week",
             plotOutput("bases_day_heatmap"))
  )
)

# Define server logic
server <- function(input, output) {
  # Text description for Trips by Hour and Month tab
  output$month_hour_description <- renderText({
    "This line graph shows trips per hour, but is broken down by each month."
  })
  
  # Trips by Hour and Month
  output$month_hour_plot <- renderPlot({
    ggplot(pivot_table_month_hour, aes(x = Hour, y = Trips, group = Month, color = factor(Month))) +
      geom_line() +
      labs(x = "Hour", y = "Number of Trips", color = "Month") +
      scale_color_discrete(name = "Month", labels = c("Apr", "May", "Jun", "Jul", "Aug", "Sep")) +
      theme_minimal()
  })
  
  # Text description for Trips by Day and Month tab
  output$month_day_description <- renderText({
    "This is a bar chart that shows the amount of trips per month, but is broken down by each day of the week."
  })
  
  # Trips by Day and Month
  output$month_day_plot <- renderPlot({
    ggplot(pivot_table_month_day_of_week, aes(x = Month, y = Trips, fill = DayOfWeek)) +
      geom_bar(stat = "identity", position = "dodge") +
      labs(x = "Month", y = "Number of Trips", fill = "Day of the Week") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })
  
  # Text description for Trips by Base and Month tab
  output$base_month_description <- renderText({
    "This is another bar chart that looks at the number trips per base, but is broken down by each month."
  })
  
  # Trips by Base and Month
  output$base_month_plot <- renderPlot({
    ggplot(pivot_table_base_month, aes(x = Base, y = Trips, fill = Month)) +
      geom_bar(stat = "identity", position = "dodge") +
      labs(x = "Base", y = "Number of Trips", fill = "Month") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })
  
  # Heat map by hour and day
  output$hour_day_heatmap <- renderPlot({
    ggplot(pivot_table_hour_day, aes(x = Hour, y = DayOfWeek, fill = Trips)) +
      geom_tile() +
      scale_fill_gradient(low = "white", high = "blue") +
      labs(x = "Hour", y = "Day of the Week", fill = "Number of Trips") +
      theme_minimal()
  })
  
  # Heat map by month and day
  output$month_day_heatmap <- renderPlot({
    ggplot(pivot_table_month_day, aes(x = Day, y = Month, fill = Trips)) +
      geom_tile() +
      scale_fill_gradient(low = "white", high = "blue") +
      labs(x = "Day of the Month", y = "Month", fill = "Number of Trips") +
      theme_minimal()
  })
  
  # Heat map by month and week
  output$month_week_heatmap <- renderPlot({
    ggplot(pivot_table_month_week, aes(x = Week, y = Month, fill = Trips)) +
      geom_tile() +
      scale_fill_gradient(low = "white", high = "blue") +
      labs(x = "Week of the Month", y = "Month", fill = "Number of Trips") +
      theme_minimal()
  })
  
  # Heat map by bases and day of week
  output$bases_day_heatmap <- renderPlot({
    ggplot(pivot_table_bases_day, aes(x = Base, y = DayOfWeek, fill = Trips)) +
      geom_tile() +
      scale_fill_gradient(low = "white", high = "blue") +
      labs(x = "Base", y = "Day of the Week", fill = "Number of Trips") +
      theme_minimal()
  })
}

# Run the application
shinyApp(ui = ui, server = server)

