#####
# Data Gathering File
# Ben Gaiser and Jeremy Russel
# 10 October 2016
# Purpose: Before starting the data processing, we load to packages, set our directories and load the data frames
#####

# Checking if packages are already installed and if not installing them
packages <- c('repmis', 'knitr', 'rmarkdown', 'Hmisc', 'ggplot2', 'pastecs', 'RCurl')
for (p in packages) {
  if (p %in% installed.packages()) require(p, character.only=TRUE) 
  else {
    install.packages(p)
    require(p, character.only=TRUE)
  }
}
# Loading the packages and creating a Bibliography BibTex file for the R-Markdown file.
repmis::LoadandCite(packages, file = 'RpackageCitations.bib')

# Setting our working directories
wrkdir <- c('C:/Users/Benji/Desktop/Statistics/Git/Repositories/data/alcohol-consumption', 
            '~/Hertie School/Fall 2016/CollaborativeSocialScienceDataAnalysis/CSSR')
repmis::set_valid_wd(wrkdir)

# Removing from Global Environment for better readability of our data frames during the data processing
rm(packages, p, wrkdir)

#####
# Loading the data frames
# 'AlcoholConsumption' is from fivethirtyeight (https://github.com/fivethirtyeight/data)
# 'swiss' is a core R data frame
#####
AlcoholConsumption <- read.csv(text = getURL("https://raw.githubusercontent.com/fivethirtyeight/data/master/alcohol-consumption/drinks.csv"))
swiss <- as.data.frame(swiss)
