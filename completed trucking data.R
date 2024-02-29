library(readxl)
library(dplyr)
library(tidyr)
library(tidyverse)
library(ggplot2)
library(stringr)

rm(list = ls())
# setting up working directory
setwd("C:\Users\kobem\Documents\Data 332\In Class\Trucking_Data.xlsx")

df_truck <- read_excel('Trucking_Data.xlsx', sheet = 2, skip = 3, .name_repair = 'universal')

#selecting columns
df <- df_truck[, c(4:15)]

#deselect columns
df <- subset(df, select = -c(...10))

#getting tthe difference in days within a colum
date_min <- min(df$Date)
date_max <- max(df$Date)

number_of_days_on_the_road <- date_max - date_min
print(number_of_days_on_the_road)

days <- difftime(max(df$Date), min(df$Date))
print(days)
number_of_days_recorded <- nrow(df)

total_hours <- sum(df$Hours)
avg_hrs_per_day_rec <- round(total_hours / number_of_days_recorded, digits = 3)
print(avg_hrs_per_day_rec)

df$fuel_cost <- df$Gallons * df$Price.per.Gallon

df$total_cost <- df$Tolls + df$Misc + df$fuel_cost

total_fuel_costs <- sum(df$fuel_cost)
total_other_expenses <- sum(df$Tolls) + sum(df$Misc)
total_gallons_consumed <- sum(df$Gallons)
total_miles_driven <- sum(df$Odometer.Ending - df$Odometer.Beginning)
df$miles_per_gallon <- (df$Odometer.Ending - df$Odometer.Beginning) / df$Gallons
df$total_cost_per_mile <- (df$Odometer.Ending - df$Odometer.Beginning) / df$total_cost


df[c('warehouse', 'starting_city_state')] <- str_split_fixed(df$Starting.Location, ',', 2)

df$starting_city_state <- gsub(',', "",df$starting_city_state)

df_starting_pivot <- df %>%
  group_by(starting_city_state) %>%
  summarize(count = n(),
            mean_size_hours = mean(Hours, na.rm = TRUE),
            sd_hours = sd(Hours, na.rm = TRUE),
            total_hours = sum(Hours, na.rm = TRUE),
            total_gallons = sum(Gallons, na.rm = TRUE)
            )

ggplot(df_starting_pivot, aes(x = starting_city_state, y = count)) + 
  geom_col() + 
  theme(axis.text = element_text(angle = 90, vjust = .5, hjust = 1))

df[c('ending warehouse', 'ending_city_state')] <- str_split_fixed(df$Delivery.Location, ',', 2)
df$ending_city_state <- gsub(',', "", df$ending_city_state)
df$ending_city_state <- str_trim(df$ending_city_state = c('left'))

df_ending_pivot <- df %>%
  group_by(ending_city_state) %>%
  summarize(count = n(),
            mean_size_hours = mean(Hours, na.rm = TRUE),
            sd_hours = sd(Hours, na.rm = TRUE),
            total_hours = sum(Hours, na.rm = TRUE),
            total_gallons = sum(Gallons, na.rm = TRUE)
            )

ggplot(df_ending_pivot, aes(x = ending_city_state, y = count)) + 
  geom_col() + 
  theme(axis.text = element_text(angle = 90, vjust = .5, hjust = 1))
