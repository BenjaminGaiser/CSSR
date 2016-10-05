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
# 1. Pair Assignment - Data Frame 2: Swiss Data Set
# Units: Percentages
# Source: Swiss Fertility and Socioeconomic Indicators (1888), R Data Set
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
packages <- c('repmis', 'knitr', 'rmarkdown', 'ggplot2', 'pastecs')
for (p in packages) {
  if (p %in% installed.packages()) require(p, character.only=TRUE) # what does that [] mean
  else {
    install.packages(p)
    require(p, character.only=TRUE)
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

swiss <- as.data.frame(swiss) # rename Variable names ***Why do we need to 
# rename variables?

plot(swiss$Fertility, swiss$Education)

# Initial Descriptive Stats
summary(swiss$Fertility)
summary(swiss$Education)



# Did not create similar factor variable as in 538 data


# Plot fertility and education -- couldn't get this to work, so opted for simple qplot
ggplotRegSwiss <- function(fit){
  ggplot(swiss, aes(Fertility, Education)) +
    geom_point(aes(colour = "black")) +
    scale_colour_discrete(name="whatever goes here") +
    stat_smooth(method = "lm", col = "black") +
    labs(title = paste("Adj. R2 = ",signif(summary(fit)$adj.r.squared, 3),
                       "Intercept =" ,signif(fit@coef[[1]],3 ),
                       "Slope =" ,signif(fit$coef[[2]], 1),
                       "P =" ,signif(summary(fit)$coef[2,4], 2))
}
# FitOfData <- lm(swiss$Fertility ~ swiss$Education, data = ) # What to do here?
# ggplotRegression(FitOfData)

qplot(swiss$Fertility, swiss$Education, colour = "orange", xlab = "Fertility", 
      ylab = "Education")









