####
#
# New R file for First Pair Assignment
# Ben Gaiser and Jeremy Russell
# 30 September 2016
# Purpose: 
# R Data
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
packages <- c('base', 'repmis', 'knitr', 'rmarkdown', 'WDI')
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

swiss <- as.data.frame(swiss) # rename Variable names