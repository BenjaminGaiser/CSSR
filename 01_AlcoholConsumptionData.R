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
packages <- c('base', 'repmis', 'knitr', 'rmarkdown', 'rbundler')
for (p in packages) {
  if (p %in% installed.packages()[,1:5]) require(p, character.only=T)
  else {
    install.packages(p)
    require(p, character.only=T)
  }
}
loaded <- base::lapply(packages, library, character.only = TRUE)
rm(pack, loaded)

# Set working directories and remove from global environment

wrkdir <- c('C:/Users/Benji/Desktop/Statistics/Git/Repositories/data/alcohol-consumption', 
            '~/Hertie School/Fall 2016/CollaborativeSocialScienceDataAnalysis/CSSR')
repmis::set_valid_wd(wrkdir)
rm(wrkdir)
getwd()



# Import data frames

drinks <- read.csv("drinks.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE, na.strings = c("", "NA"))


