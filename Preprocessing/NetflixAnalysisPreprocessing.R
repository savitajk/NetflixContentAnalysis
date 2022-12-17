data<-read.csv("Netflix_analytics_dataset.csv")

library(xlsx)
library(openxlsx)
library(dplyr)
library(tidyr)
library(modeest)

colSums(is.na(data))

df<-na.omit(data)
df1<- df %>%
  separate(date_added,c("Month"))
df1<-df1[!is.na(df1$Month),]
df1$Month[df1$Month==""]<-mfv(df1$Month)

df1$Month<-factor(df1$Month,levels = month.name)

df2<-separate_rows(df1,country,show_id , convert = TRUE, sep = ', ')
country_count<-sort(table(df2$country),decreasing=TRUE)[1:10]
country_count<-data.frame(country_count)

write.xlsx(df,"netflix/df.xlsx")
write.xlsx(df1,"netflix/df1.xlsx")
write.xlsx(df2,"netflix/df2.xlsx")
write.xlsx(country_count,"netflix/country_count.xlsx")