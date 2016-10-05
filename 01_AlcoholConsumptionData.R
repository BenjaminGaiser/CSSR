####
#
# New R file for First Pair Assignment
# Ben Gaiser and Jeremy Russell
# 30 September 2016
# Purpose: 
# fivethirtyeight data set
# cite R and R packages used
# Style Guide:
#
####

#####
# 1. Pair Assignment
#####

# README.md file
# Human Readable
# Include 2 R Core Data Sets
# Relevant descriptive statistics
# Dynamically Linked
# Pull Request with another pair

# Set global options for viewability
options(max.print = 100)
getOption("max.print")

# Load packages and remove from global environment
packages <- c('base', 'repmis', 'knitr', 'rmarkdown', 'WDI', 'ggplot2')
for (p in packages) {
  if (p %in% installed.packages()[,1:4]) require(p, character.only=T)
  else {
    install.packages(p)
    require(p, character.only=T)
  }
}
repmis::LoadandCite(packages, file = 'RpackageCitations.bib')
rm(packages, p)

# Set working directories and remove from global environment

wrkdir <- c('C:/Users/Benji/Desktop/Statistics/Git/Repositories/data/alcohol-consumption', 
            '~/Hertie School/Fall 2016/CollaborativeSocialScienceDataAnalysis/CSSR')
repmis::set_valid_wd(wrkdir)
rm(wrkdir)

# Import data frames

AlcoholConsumption <- read.csv("drinks.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE, na.strings = c("", "NA"))

# Alcohol Consumption -> ggplot it
plot(AlcoholConsumption$beer_servings)
plot(AlcoholConsumption$wine_servings)
plot(AlcoholConsumption$spirit_servings)
plot(AlcoholConsumption$total_litres_of_pure_alcohol)

#
which.max(AlcoholConsumption$total_litres_of_pure_alcohol) # row 16
head(AlcoholConsumption[16,]) # Belarus
which.min(AlcoholConsumption$total_litres_of_pure_alcohol) # row 1
head(AlcoholConsumption[1,]) # Afghanistan

# Find Germany, USA, South Africa, China and Australia
which(grepl("Germany", AlcoholConsumption$country)) # row 66
which(grepl("USA", AlcoholConsumption$country)) # row 185
which(grepl("South Africa", AlcoholConsumption$country)) # row 160
which(grepl("China", AlcoholConsumption$country)) # row 37
which(grepl("Australia", AlcoholConsumption$country)) # row 9

# Subset for graphs
subset <- AlcoholConsumption[c(9, 37, 66, 160, 185),]
ggplot(subset, aes(x = subset$country, 
                               y = subset$beer_servings)) + geom_point()

# WDI?
WDIsearch(string = "gdp") # GDPPCKD = GDP Per Capita, constant US$, millions
WDI <- WDI(country = "all", indicator = "NY.GNS.ICTR.GN.ZS", start=2010, end=2010, extra=TRUE, cache=NULL)
