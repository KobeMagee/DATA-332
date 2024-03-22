# Consumer Complaint Sentiment Analysis

## Introduction
I analyzed a data set that consists of consumer complaints from various financial institutions. 

## Dictionary
1) Date.reveived: when the complaint was received
2) Complaint.ID: unique id for each complaint
3) Product: specific item the complaint was about
4) Issue: reason for complaint
5) Consumer.complaint.narrative: the complaint each consumer wrote
6) Company: what company the complaint was about
7) State: state where the consumer filed the complaint

## Data Cleaning
Replaced all blanks with NA
```
complaint_data[complaint_data ==''] <- NA
```
Filtered by certain columns and fileted out NA responses
```
clean_complaint_data <- complaint_data %>%
  select(Date.received, Complaint.ID, Product, Issue, Consumer.complaint.narrative, Company, State) %>%
  filter(!is.na(Consumer.complaint.narrative))
```
## Data Summary
	
| Company                                 | Positive | Negative | Score  |
|-----------------------------------------|----------|----------|--------|
| Equifax                                 | 27052    | -60117   | -33065 |
| Experian                                | 25548    | -55031   | -29483 |
| Bank of America                         | 37094    | -64953   | -27859 |
| TransUnion Intermediate Holdings, Inc.  | 21376    | -45429   | -24053 |
| Wells Fargo & Company                   | 40606    | -63887   | -23281 |
| JPMorgan Chase & Co.                    | 29791    | -50709   | -20918 |
| Citibank                                | 38059    | -56443   | -18384 |
| Capital One                             | 13420    | -25390   | -11970 |
| Ocwen                                   | 17016    | -28128   | -11112 |
| Nationstar Mortgage                     | 14932    | -24606   | -9674  |
| Synchrony Financial                     | 12121    | -20717   | -8596  |
| Encore Capital Group                    | 4690     | -12667   | -7977  |
| Ditech Financial LLC                    | 11163    | -19049   | -7886  |
| U.S. Bancorp                            | 12490    | -19939   | -7449  |
| Portfolio Recovery Associates, Inc.     | 2847     | -9303    | -6456  |
| Amex                                    | 10062    | -15513   | -5451  |
| Navient Solutions, Inc.                 | 13409    | -18695   | -5286  |
| ERC                                     | 2466     | -7707    | -5241  |
| PayPal Holdings, Inc.                   | 5113     | -9475    | -4362  |
| Select Portfolio Servicing, Inc         | 6246     | -10554   | -4308  |

## Data Analysis
# Companies with the worst sentiment scores
<img src="Graphs and Word Cloud/Sentiment Analysis Bottom 20.png" height = 500, width = 800>

1) Used get_sentiments('afinn') to sum the scores together
2) Then created this graph showing the 20 companies with the lowest scores

# Equifax NRC
<img src="Graphs and Word Cloud/Equifax NRC.png" height = 600, width = 800>

1) Used get_sentiment('nrc') and filtered it by 'anger'
2) Then filtered by company and using inner_join to joing nrc_anger
3) Then created this graph showing the top 5 words for Equifax
4) Shows that 'dispute' was by ffar the highest word

# Bing Negative
<img src="Graphs and Word Cloud/Negative Bing.png" height = 600, width = 800>

1) Used get_sentiments('bing') and filtered it by 'negative'
2) Inner joined bing_negative with my company_analysis that had each word recorded in the complaints
3) Then created this graph showing the top 10 words recorded
4) Shows that 'debt' was by far the highest word

# Word Cloud
<img src="Graphs and Word Cloud/wordcloud.png" height = 400, width = 600>

1) Shows that a majority of the complaints had negative words in them

## Conclusion
1) The sentiment analysis shows an overall negative trend towards the companies
2) Equifax had the worst score at -33,065
3) 'Debt' was the most recorded word Bing analysis




