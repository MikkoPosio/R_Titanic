setwd("C:/R_project/Titanic")
library(ggplot2)
library(ggthemes)
library(scales)
library(dplyr)
library(lattice)
library(mice)
library(randomForest)
train <- read.csv("C:/R_project/Titanic/train.csv")
View(train)
test <- read.csv("C:/R_project/Titanic/test.csv")
View(test)
full <- bind_rows(train, test)
str(full)
# Grab title from passenger names
full$Title <- gsub('(.*, )|(\\..*)', '', full$Name)
table(full$Sex, full$Title)
rare_title <- c('Dona', 'Lady', 'the Countess','Capt', 'Col', 'Don', 
                'Dr', 'Major', 'Rev', 'Sir', 'Jonkheer')
# Also reassign mlle, ms, and mme accordingly
full$Title[full$Title == 'Mlle']        <- 'Miss' 
full$Title[full$Title == 'Ms']          <- 'Miss'
full$Title[full$Title == 'Mme']         <- 'Mrs' 
full$Title[full$Title %in% rare_title]  <- 'Rare Title'
table(full$Sex, full$Title)
full$Surname <- sapply(full$Name,  
                       function(x) strsplit(x, split = '[,.]')[[1]][1])
cat(paste('We have <b>', nlevels(factor(full$Surname)), '</b> unique surnames. I would be interested to infer ethnicity based on surname --- another time.'))
  ##### https://www.kaggle.com/mrisdal/exploring-survival-on-the-titanic  ##########