#Loading Tidyvese Package

library(tidyverse)

#Reading the dataset

#CoalData<-read_csv("http://594442.youcanlearnit.net/coal.csv")
CoalData<-read_csv("original data/coal.csv")
glimpse(CoalData)
CoalData<-read_csv("original data/coal.csv",skip=2)
colnames(CoalData)[1]<-"Region"
summary(CoalData)
CoalData
#Transforming the wide datset to long

CoalData_long<-gather(CoalData,"year","Coal_Consumption",-Region)
CoalData_long
glimpse(CoalData_long)
summary(CoalData_long)

CoalData_long$year<-as.integer(CoalData_long$year)
CoalData_long$Coal_Consumption<-as.numeric(CoalData_long$Coal_Consumption)

unique(CoalData_long$Region)

non_countries<-c("North America","Central & South America","Antarctica","Africa" ,"Europe","Eurasia","Middle East",
                 "Australia","Asia & Oceania","World")

matches<-which(!is.na(match(CoalData_long$Region,non_countries)))

coal_Country<-CoalData_long[-matches,]
coal_region<-CoalData_long[matches,]

unique(coal_Country$Region) 
unique(coal_region$Region)



# Start with a scatterplot
ggplot(data=coal_region, mapping=aes(x=year, y=coal_consumption)) +
  geom_point()

# That looks like it should be a line graph
ggplot(data=coal_region, mapping=aes(x=year, y=coal_consumption)) +
  geom_line()

# Let's get a separate line for each region
ggplot(data=coal_region, mapping=aes(x=year, y=coal_consumption)) +
  geom_line(mapping=aes(color=region))


