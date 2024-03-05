## attach libraries
library(tidyverse)
library(readxl)
library(here)
library(skimr) # install.packages('skimr')
library(kableExtra) # install.packages('kableExtra')

setwd('C:/Users/kobem/Documents/GitHub/DATA-332')
lobsters <- read.csv('Lobster_Abundance_All_Years_20230831.csv')

skimr::skim(lobsters)
lobsters %>%
  group_by(SITE, YEAR) %>% 
  summarize(count_by_year = n(), 
            mean_size_mm = mean(SIZE_MM, na.rm=TRUE),
            sd_size_mm = sd(SIZE_MM, na.rm=TRUE)
            
            )
lobsters <- lobsters %>%
  dplyr::filter(SIZE_MM > 0)
siteyear_summary <- lobsters %>%
  group_by(SITE, YEAR) %>%
  summarize(count_by_siteyear =  n(), 
            mean_size_mm = mean(SIZE_MM, na.rm = TRUE), 
            sd_size_mm = sd(SIZE_MM, na.rm = TRUE),
            median_size_mm = median(SIZE_MM, na.rm = TRUE)
            )
siteyear_summary

siteyear_summary %>%
  kable()

## a ggplot option:
ggplot(data = siteyear_summary, aes(x = YEAR, y = median_size_mm, color = SITE)) +
  geom_line() 
ggsave("lobsters-col.png")

## another option:
ggplot(siteyear_summary, aes(x = YEAR, y = median_size_mm)) +
  geom_col() +
  facet_wrap(~SITE)
