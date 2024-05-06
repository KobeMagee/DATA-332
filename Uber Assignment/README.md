# Uber Data Analysis

## Introduction

This README file provides an overview of the steps involved in analyzing Uber trip data and creating seven different graphs using R.
Here is the link to my shiny app with the charts.
https://kobemagee20.shinyapps.io/Uber_Charts/

## Steps to Create Graphs

1. **Data Loading and Combining:**
   - Loaded Uber trip data for the months of April to September 2014 from separate CSV files (`uber-raw-data-apr14.csv`, `uber-raw-data-may14.csv`, etc.).
   - Combined all the individual month datasets into one dataframe (`combined_df`) using the `rbind()` function.
   - ```
     df_apr <- read.csv('uber-raw-data-apr14.csv')
     df_may <- read.csv('uber-raw-data-may14.csv')
     df_jun <- read.csv('uber-raw-data-jun14.csv')
     df_jul <- read.csv('uber-raw-data-jul14.csv')
     df_aug <- read.csv('uber-raw-data-aug14.csv')
     df_sep <- read.csv('uber-raw-data-sep14.csv')
     # Bind all the data together
     combined_df <- rbind(df_apr, df_may, df_jun, df_jul, df_aug, df_sep)
     ```

2. **Data Preparation:**
   - Changed the `Date` column to a date schema using the `as.Date()` function.
   - Converted the `Date.Time` column to POSIXct format with the appropriate format using the `as.POSIXct()` function.
   - Extracted the hour from the `Date.Time` column and stored it in a new column named `Hour`.
   - Extracted the month from the `Date.Time` column and stored it in a new column named `Month`.
   - ```
     combined_df$Date <- as.Date(combined_df$Date.Time, format = "%m/%d/%Y")

     combined_df$Date.Time <- as.POSIXct(combined_df$Date.Time, format = "%m/%d/%Y %H:%M:%S")

     combined_df$Hour <- as.POSIXlt(combined_df$Date.Time)$hour

     combined_df$Month <- as.numeric(format(combined_df$Date.Time, "%m"))
     ```

3. **Trips by Hour and Month:**
   - Created a pivot table (`pivot_table_month_hour`) to display the number of trips by hour and month.
   - Grouped the data by `Month` and `Hour` and calculated the total number of trips for each combination using `summarise()`.
  
   - ```
     pivot_table_month_hour <- combined_df %>%
     	group_by(Month, Hour) %>%
     	summarise(Trips = n())
     ```

4. **Trips by Day and Month:**
   - Created a pivot table (`pivot_table_month_day_of_week`) to display the number of trips by day of the week and month.
   - Grouped the data by `Month` and `DayOfWeek` and calculated the total number of trips for each combination using `summarise()`.
   - ```
     pivot_table_month_day_of_week <- combined_df %>%
     	group_by(Month, DayOfWeek) %>%
     	summarise(Trips = n())
     ```

5. **Trips by Base and Month:**
   - Created a pivot table (`pivot_table_base_month`) to display the number of trips by Uber base and month.
   - Grouped the data by `Base` and `Month` and calculated the total number of trips for each combination using `summarise()`.
   - ```
     pivot_table_base_month <- combined_df %>%
     	group_by(Base, Month) %>%
     	summarise(Trips = n())
     ```

6. **Heat Map by Hour and Day:**
   - Created a pivot table (`pivot_table_hour_day`) to display the number of trips by hour and day of the week.
   - Grouped the data by `Hour` and `DayOfWeek` and calculated the total number of trips for each combination using `summarise()`.
   - ```
     pivot_table_hour_day <- combined_df %>%
     	group_by(Hour, DayOfWeek) %>%
     	summarise(Trips = n())
     ```

7. **Heat Map by Month and Day:**
   - Created a pivot table (`pivot_table_month_day`) to display the number of trips by month and day.
   - Grouped the data by `Month` and `Day` and calculated the total number of trips for each combination using `summarise()`.
   - ```
     pivot_table_month_day <- combined_df %>%
     	group_by(Month, Day) %>%
     	summarise(Trips = n())
     ```

8. **Heat Map by Month and Week:**
   - Created a pivot table (`pivot_table_month_week`) to display the number of trips by month and week.
   - Defined a function `get_week()` to calculate the week number within each month.
   - Mutated the dataframe to include a new column `Week` indicating the week number.
   - Grouped the data by `Month` and `Week` and calculated the total number of trips for each combination using `summarise()`.
   - ```
     get_week <- function(day) {
     	week_num <- ceiling(day / 7)
     	paste0("Week ", week_num)
     }

     pivot_table_month_week <- combined_df %>%
     	mutate(Week = get_week(Day)) %>%
     	group_by(Month, Week) %>%
     	summarise(Trips = n())
     ```

9. **Heat Map Bases and Day of Week:**
   - Created a pivot table (`pivot_table_bases_day`) to display the number of trips by Uber base and day of the week.
   - Grouped the data by `Base` and `DayOfWeek` and calculated the total number of trips for each combination using `summarise()`.
   - ```
     pivot_table_bases_day <- combined_df %>%
     	group_by(Base, DayOfWeek) %>%
     	summarise(Trips = n())
     ```
