library(readxl)
library(dplyr)
library(tidyr)
library(tidyverse)
library(ggplot2)
library(stringr)

setwd("C:/Users/kobem/Documents/GitHub/DATA-332/Patient Data")
df_billing <- read_xlsx('Billing.xlsx')
df_patient <- read_xlsx('Patient.xlsx')
df_vistit <- read_xlsx('Visit.xlsx')

merged_data <- merge(df_billing, df_vistit, by = "VisitID", all.x = TRUE)
final_merged_data <- merge(merged_data, df_patient, by = "PatientID", all.x = TRUE)

final_merged_data$VisitDate <- as.Date(final_merged_data$VisitDate)

final_merged_data <- final_merged_data %>%
  mutate(VisitMonth = format(VisitDate, "%m"))

#Question 1
df_visit_month <- final_merged_data %>%
  group_by(VisitMonth, Reason) %>%
  summarize(Count = n())

df_visit_month$VisitMonth <- factor(df_visit_month$VisitMonth, levels = unique(df_visit_month$VisitMonth))

ggplot(df_visit_month, aes(x = VisitMonth, y = Count, fill = Reason)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = Count), position = position_stack(vjust = 0.5), size = 3, color = "white") +
  labs(title = "Visit Count by Reason and Month",
       x = "Month",
       y = "Count") +
  theme_minimal() +
  scale_fill_viridis_d()

#Question 2
df_walkin_reason <- final_merged_data %>%
  group_by(Reason, WalkIn) %>%
  summarize(Count = n())

ggplot(df_walkin_reason, aes(x = Reason, y = Count, fill = WalkIn)) +
  geom_bar(position = "stack", stat = "identity") +
  geom_text(aes(label = Count), position = position_stack(vjust = 0.5), size = 3, color = "white") +
  labs(title = "Reason for Visit Segmented by Walk-In Status",
       x = "Reason",
       y = "Count") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5, size = 8)) +
  scale_fill_viridis_d()

#Question 3
df_reason_city <- final_merged_data %>%
  group_by(Reason, City) %>%
  summarize(Count = n())

ggplot(df_reason_city, aes(x = Reason, y = Count, fill = City)) +
  geom_bar(position = "stack", stat = "identity") +
  geom_text(aes(label = Count), position = position_stack(vjust = 0.5), size = 3, color = "white") +
  labs(title = "Reason for Visit Segmented by City",
       x = "Reason",
       y = "Count") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5, size = 8)) +
  scale_fill_viridis_d()


#Question 4
df_invoice_reason <- final_merged_data %>%
  group_by(Reason, InvoicePaid) %>%
  summarise(TotalInvoiceAmount = sum(InvoiceAmt))

ggplot(df_invoice_reason, aes(x = Reason, y = TotalInvoiceAmount, fill = factor(InvoicePaid))) +
  geom_bar(position = "stack", stat = "identity") +
  labs(title = "Total Invoice Amount by Reason and Payment Status",
       x = "Reason",
       y = "Total Invoice Amount") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5, size = 8)) +
  scale_fill_manual(values = c("red", "green"), name = "Invoice Paid")


