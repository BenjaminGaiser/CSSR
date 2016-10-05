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
packages <- c('repmis', 'knitr', 'rmarkdown', 'ggplot2')
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

AlcoholConsumption <- read.csv("drinks.csv", header = TRUE, sep = ",", 
                               stringsAsFactors = FALSE, na.strings = c("", "NA"))

# For intuition
#c <- ggplot(AlcoholConsumption, aes(beer_servings,
#                                    total_litres_of_pure_alcohol))
# Create heavy wine/spirit drinker categories and use as factor
#d <- c + geom_point()
# for size
#c + geom_point(aes(size = qsec))

#p + geom_point(aes(colour = factor(cyl)), size = 4) +
#  geom_point(colour = "grey90", size = 1.5)

#c + geom_point() + geom_smooth()
#c + geom_point() + geom_smooth(method = "lm", se = FALSE)
#c + geom_point() + geom_smooth(method = "lm", se = TRUE)
summary(AlcoholConsumption$beer_servings)
summary(AlcoholConsumption$total_litres_of_pure_alcohol)

# Create heavy wine/spirit drinker categories and use as factor
summary(AlcoholConsumption$wine_servings)
AlcoholConsumption$WineCat1 <- cut(AlcoholConsumption$wine_servings, seq(0, 370, 50))
summary(AlcoholConsumption$WineCat1)

ggplotRegression <- function(fit){
  ggplot(AlcoholConsumption, aes(beer_servings, total_litres_of_pure_alcohol)) +
    geom_point(aes(colour = factor(AlcoholConsumption$WineCat1))) +
    scale_colour_discrete(name="Wine Servings") +
    stat_smooth(method = "lm", col = "red") +
    labs(title = paste("Adj R2 = ",signif(summary(fit)$adj.r.squared, 3),
                       "Intercept =",signif(fit$coef[[1]],3 ),
                       " Slope =",signif(fit$coef[[2]], 1),
                       " P =",signif(summary(fit)$coef[2,4], 2)))
}
FitOfData <- lm(total_litres_of_pure_alcohol ~ beer_servings, data=AlcoholConsumption)
ggplotRegression(FitOfData)

# Who drinks the most and the least amount of total litres of pure alcohol
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

# SubsetOfFiveCountries for graphs
SubsetOfFiveCountries <- AlcoholConsumption[c(9, 37, 66, 160, 185),]

IndividualCountries <- ggplot(SubsetOfFiveCountries, 
                              aes(beer_servings, total_litres_of_pure_alcohol))
IndividualCountries + geom_point(aes(colour = factor(country))) +
  scale_colour_discrete(name="Countries")
