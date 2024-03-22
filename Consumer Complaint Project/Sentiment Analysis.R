library(tidytext)
library(readxl)
library(dplyr)
library(tidyr)
library(tidyverse)
library(ggplot2)
library(stringr)
library(janeaustenr)
library(wordcloud)
library(reshape2)
library(wordcloud2)

setwd("C:/Users/kobem/Documents/GitHub/DATA-332/Consumer Complaint Project")
complaint_data <- read.csv('Consumer_Complaints.csv')

get_sentiments("afinn")
get_sentiments("bing")
get_sentiments("nrc")

#remove blanks
complaint_data[complaint_data ==''] <- NA

#get rid of not needed columns and filter out rows with NA
clean_complaint_data <- complaint_data %>%
  select(Date.received, Complaint.ID, Product, Issue, Consumer.complaint.narrative, Company, State) %>%
  filter(!is.na(Consumer.complaint.narrative))

#text analysis
text_analysis <- clean_complaint_data %>%
  unnest_tokens(word, Consumer.complaint.narrative)

company_analysis <- text_analysis %>%
  inner_join(get_sentiments('afinn'))

company_analysis <- company_analysis %>%
  mutate(Consumer.complaint.narrative)

#finding each companies sentiment score
company_value <- company_analysis %>%
  group_by(Company) %>%
  summarize(
    positve = sum(value[value > 0]),
    negative = sum(value[value < 0]),
    score = sum(value)
    ) %>%
  arrange(score)

#graphing the 20 companies with the worst scores
top_20_companies <- company_value %>%
  head(20)

ggplot(top_20_companies, aes(y = reorder(Company, score), x = score, fill = factor(sign(score)))) +
  geom_bar(stat = "identity") +
  labs(title = "Sentiment of Bottom 20 Companies",
       y = "Company",
       x = "Sentiment Score") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1),
        legend.position = "none") + 
  coord_flip()

#NRC
nrc_angry <- get_sentiments('nrc') %>%
  filter(sentiment == 'anger')

equifax_words <- company_analysis %>% 
  filter(Company == 'Equifax') %>%
  inner_join(nrc_angry) %>%
  count(word, sort = TRUE) %>%
  top_n(5)

#graph for top 5 angry words in Equifax
ggplot(equifax_words, aes(y = reorder(word, n), x = n)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = n), vjust = -0.5, size = 3) +
  labs(title = "Top 5 Words for Equifax with NRC Angry",
       y = "Word",
       x = "Frequency") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  coord_flip()

#bing negative
bing_negative <- get_sentiments('bing') %>%
  filter(sentiment == 'negative')

bing_sentiment <- company_analysis %>%
  inner_join(bing_negative, by = 'word') %>%
  count(word, sort = TRUE)

ggplot(head(bing_sentiment, 10), aes(y = reorder(word, n), x = n)) +
  geom_bar(stat = "identity", fill = "red") +
  geom_text(aes(label = n), vjust = -0.5, size = 3) +
  labs(title = "Top 10 Words with Negative Sentiment (Bing)",
       y = "Word",
       x = "Frequency") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  coord_flip()

#word cloud
word_count <- company_analysis %>%
  count(word)
wordcloud2(word_count)
       