ccdf<-read.csv('netflix_cast_and_crew.csv')
dordf<-read.csv('netflix_date_of_release.csv')
desc1df<-read.csv('netflix_description1.csv')
desc2df<-read.csv('netflix_description2.csv')
tcdf<-read.csv('netflix_type_countries.csv')

#row-wise combination
descdf<-rbind(desc1df,desc2df)

#left outer join
dfcctcdf<-merge(x=ccdf,y=tcdf,all.x=TRUE)

#inner join
nfwddf<-merge(dfcctcdf,dordf)
nfdf<-merge(nfwddf,descdf)

write.csv(nfdf,"Netflix_analytics_dataset.csv", row.names=FALSE)

library(dplyr)
df<-tibble::as_tibble(nfdf) %>% select(-c(show_id,description))

write.csv(df,"Netflix_dataset.csv", row.names=FALSE)

df$type<-factor(df$type)

typebyyear<-table(df$release_year,df$type,group_by(df$release_year))
df2<-data.frame(typebyyear)
write.csv(df2,"Netflix_dataset_type_by_year.csv", row.names=FALSE)
