####
#
# New R file for First Pair Assignment
# Ben Gaiser and Jeremy Russell
# 30 September 2016
# Purpose: 
# fivethirtyeight data set
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
  if (p %in% installed.packages()[,]) library(p, character.only=T)
  else {
    install.packages(p)
    library(p, character.only=T)
  }
}
loaded <- base::lapply(pack, library, character.only = TRUE)
rm(pack, loaded)

# Set working directories and remove from global environment

wrkdir <- c('C:/Users/Benji/Desktop/Statistics/Git/Repositories/CSSR', 
            'Add your wrkdir')
repmis::set_valid_wd(wrkdir)
rm(wrkdir)

# Import data frames

AlcoholConsumption <- read.csv("drinks.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE, na.strings = c("", "NA"))
