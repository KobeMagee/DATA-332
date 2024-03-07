library(readxl)
library(dplyr)
library(tidyr)
library(tidyverse)
library(ggplot2)
library(stringr)
library(lubridate)

setwd('C:/Users/kobem/Documents/GitHub/DATA-332/Student Data')
df_student <- read_xlsx('Student.xlsx')
df_course <- read_xlsx('Course.xlsx')
df_reg <- read_xlsx('Registration.xlsx')

merged_data <- left_join(df_student, df_reg, by = 'Student ID')
final_data <- left_join(merged_data, df_course, by = "Instance ID")
view(final_data)

df_majors <- final_data %>%
  group_by(Title) %>%
  summarise(count = n())

ggplot(df_majors, aes(x = Title, y = count)) +
  geom_col() + 
  theme(axis.text = element_text(angle = 90, vjust = .5, hjust = 1))

final_data$birth_year <- year(final_data$`Birth Date`)

df_birth_year <- final_data %>%
  group_by(birth_year) %>%
  summarize(count = n())

ggplot(df_birth_year, aes(x = birth_year, y = count)) +
  geom_col()

cost_per_major <- final_data %>%
  group_by(Title, `Payment Plan`) %>%
  summarize(`Total Cost` = sum(`Total Cost`), count= n())

ggplot(cost_per_major, aes(x = Title, y = cost_per_major$`Total Cost`, fill = cost_per_major$`Payment Plan`))+
  geom_bar(stat = "identity", position = "stack") +
  labs(x = "Major", y = "Cost", fill = cost_per_major$`Payment Plan`) +
  scale_fill_manual(values = c("black", "red"), labels = c("False", "True")) +
  theme(axis.text = element_text(angle = 60, vjust = .5, hjust = 1))

balance_per_major <- final_data %>%
  group_by(Title, `Payment Plan`) %>%
  summarise(`Total Cost` = sum(`Balance Due`), count = n())

ggplot(balance_per_major, aes(x = Title, y = balance_per_major$`Total Cost`, fill = balance_per_major$`Payment Plan`))+
  geom_bar(stat = "identity", position = "stack") +
  labs(x = "Major", y = "Balance Due", fill = balance_per_major$`Payment Plan`) +
  scale_fill_manual(values = c("black", "red"), labels = c("False", "True")) +
  theme(axis.text = element_text(angle = 60, vjust = .5, hjust = 1))
