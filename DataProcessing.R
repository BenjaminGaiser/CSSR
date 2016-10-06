#####
# Data Processing File
# Ben Gaiser and Jeremy Russel
# 10 October 2016
# Purpose: Some preliminary descriptive statistics for our two data frames
#####

# Executing the Data Gathering File
source('C:/Users/Benji/Desktop/Statistics/Git/Repositories/CSSR/DataGathering.R')

#####
# Data Frame 1: Alcohol Consumption 
# Units: Average serving sizes per person  
# Source: 538 from World Health Organisation, Global Information System on Alcohol and Health (GISAH), 2010
# Variables of interest: 
#   Independent Variable X: 'beer_servings'
#   Dependent Variable Y: 'total_litres_of_pure_alcohol'
#####

# How does the data look like - Initial Descriptive Statistics
summary(AlcoholConsumption)
describe(AlcoholConsumption)

# Who drinks the most amounts of total litres of pure alcohol?
which.max(AlcoholConsumption$total_litres_of_pure_alcohol)
# The answer is row 16 or better said Belarus.
head(AlcoholConsumption[16,])
# Who drinks the least amounts of total litres of pure alcohol?
which.min(AlcoholConsumption$total_litres_of_pure_alcohol) 
# The answer is row 1 or better said Afghanistan.
head(AlcoholConsumption[1,])

#####
# Hypothesis: Beer is the main driver for total litres of pure alcohol consumed per country
#####

# Looking at the Correlation to see if Hypothesis might be right
cor(AlcoholConsumption$beer_servings, AlcoholConsumption$total_litres_of_pure_alcohol)    # 0.84
cor(AlcoholConsumption$wine_servings, AlcoholConsumption$total_litres_of_pure_alcohol)    # 0.67
cor(AlcoholConsumption$spirit_servings, AlcoholConsumption$total_litres_of_pure_alcohol)  # 0.65
# It seems that beer_servings are most closely correlated to total_litres_of_pure_alcohol

#####
# Plotting our finding in a scatterplot with a line of best fit and the 95 % confidence interval
#####

# 1. Step: Creating a function for plotting a ggplot
ggplotRegAlcCons <- function(fit){
  ggplot(AlcoholConsumption, aes(beer_servings, total_litres_of_pure_alcohol)) +
    geom_point(colour = 'blue') +
    stat_smooth(method = 'lm', col = 'red', size=0.75) +
    labs(title = paste('Adj R2 = ',signif(summary(fit)$adj.r.squared, 3),
                       'Intercept =',signif(fit$coef[[1]],3 ),
                       ' Slope =',signif(fit$coef[[2]], 1),
                       ' P =',signif(summary(fit)$coef[2,4], 2)))
}

# 2. Step: Running the linear regression for the line of best fit
FitOfData <- lm(total_litres_of_pure_alcohol ~ beer_servings, data=AlcoholConsumption)

# 3. Step: Plotting the graph
ggplotRegAlcCons(FitOfData)
# Beer seems indeed to explain the story well with an Adj.R²-value of 0.70

#####
# Taking five countries of interest to see how they differ in their 'beer_servings' values
#####

# Finding Germany, USA, South Africa, China and Australia
which(grepl('Germany', AlcoholConsumption$country)) # row 66
which(grepl('USA', AlcoholConsumption$country)) # row 185
which(grepl('South Africa', AlcoholConsumption$country)) # row 160
which(grepl('China', AlcoholConsumption$country)) # row 37
which(grepl('Australia', AlcoholConsumption$country)) # row 9

# Subsetting the Data 'AlcoholConsumption' for ease of commanding
SubsetOfFiveCountries <- AlcoholConsumption[c(9, 37, 66, 160, 185),]

# Plotting our finding in a Scatterplot, we see that Germany drinks most out of the five countries on both variables
ggplot(SubsetOfFiveCountries,
       aes(beer_servings, total_litres_of_pure_alcohol)) + 
  geom_point(aes(colour = factor(country))) +
  scale_colour_discrete(name='Countries')

#####
# Data Frame 2: Swiss Data Set 
# Variables of interest: 
#   Independent Variable X: 'Catholic': % of males involved in agriculture as occupation
#   Dependent Variable Y: 'Fertility': lg, 'common standardized fertility measure'
# Source: Swiss Fertility and Socioeconomic Indicators (1888), R Data Set
#####

# How does the data look like - Initial Descriptive Statistics
summary(swiss)

#####
# Hypothesis: Catholics have a higher fertility rate than Protestants
#####

# Look closer at the initial descriptives statistics of our variables of interest
describe(swiss$Fertility)
describe(swiss$Catholic)
var(swiss$Fertility)
var(swiss$Catholic)
sd(swiss$Fertility)
sd(swiss$Catholic)
# 'Catholic' shows high variance and standard deviation for a continuous variable of between 0 and 100

# Plotting both variables to get see for their relationship
ggplot(swiss, aes(Catholic, Fertility)) + geom_point()

# Plot fertility and Catholic with ggplot
ggplotRegSwiss <- function(fit){
  ggplot(swiss, aes(Catholic, Fertility)) +
    geom_point(colour = 'blue') +
    stat_smooth(method = 'lm', col = 'red', size=0.75) +
    labs(title = paste('Adj R2 = ',signif(summary(fit)$adj.r.squared, 3),
                       'Intercept =',signif(fit$coef[[1]],3 ),
                       ' Slope =',signif(fit$coef[[2]], 1),
                       ' P =',signif(summary(fit)$coef[2,4], 2)))
}
FitOfDataSwiss <- lm(Fertility ~ Catholic, data = swiss)
ggplotRegSwiss(FitOfDataSwiss)
# Despite outliers, this is still a significant relationship, explaining 20 % of the variance (R²-value)

#####
# Which cantons are not part of the either almost total Protestant, or almost Catholic branches?
#####

# 1. Step: Creating a factor variable with four different groups
swiss$CatholicCat <- cut(swiss$Catholic, seq(0, 100, 25))
# 2. Step: Changing the factor variable into a character variable for renaming the rownames
swiss$CatholicCat <- as.character(swiss$CatholicCat)
# 3. Step: Renaming the rownames
swiss$CatholicCat[swiss$CatholicCat=='(0,25]'] <- 'Protestant'
swiss$CatholicCat[swiss$CatholicCat=='(25,50]'] <- 'Protestant to Catholic'
swiss$CatholicCat[swiss$CatholicCat=='(50,75]'] <- 'Catholic to Protestant'
swiss$CatholicCat[swiss$CatholicCat=='(75,100]'] <- 'Catholic'
# 4. Step: Finding the cantons which are 'Protestant to Catholic' and 'Catholic to Protestant'
which(grepl('Protestant to Catholic', swiss$CatholicCat)) # 4 and 45
which(grepl('Catholic to Protestant', swiss$CatholicCat)) # 46 and 47
# 5. Step: Searching the names
swiss[c(4,45:47),]
# Moutier, V. De Geneve, Rive Droite and Rive Gauce are the only cantons where there is at least a third of the population
# that does not belong into the majority religion
