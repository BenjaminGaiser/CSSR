#####
# Data Gathering File
# Ben Gaiser and Jeremy Russell
# 7 October 2016
# Purpose: Before starting the data processing, we load certain packages, 
# set our directories and load the data frames
#####

# Installing packages
packages <- c('repmis', 'knitr', 'rmarkdown', 'Hmisc', 'ggplot2', 'pastecs', 'RCurl')
for (p in packages) {
  if (p %in% installed.packages()) require(p, character.only=TRUE) 
  else {
    install.packages(p)
    require(p, character.only=TRUE)
  }
}
# Creating a BibTex file
repmis::LoadandCite(packages, file = 'RpackageCitations.bib')

# Setting our working directory
wrkdir <- c('C:/Users/Benji/Desktop/Statistics/Git/Repositories/CSSR', 
            '~/Hertie School/Fall 2016/CollaborativeSocialScienceDataAnalysis/CSSR')
repmis::set_valid_wd(wrkdir)

# Removing from global environment for better readability
rm(packages, p, wrkdir)

#####
# Loading the data frames
# Alcohol Consumption data set is from fivethirtyeight (https://github.com/fivethirtyeight/data). 
# Swiss is a core R data frame
#####
AlcoholConsumption <- read.csv(text = getURL("https://raw.githubusercontent.com/fivethirtyeight/data/master/alcohol-consumption/drinks.csv"))
swiss <- as.data.frame(swiss)
