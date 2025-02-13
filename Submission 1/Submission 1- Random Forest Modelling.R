# This is my first try and attempt at Machine Learning for the Kaggle Titanic Machine Learning competition. 
# I've always been more of a data analyst and this has been an eye opener about what's our there to look at bigger amount of data. 
# A big shout out and thank you to Kris Smith for your guide and walkthrough about how to use the dataset with the Random Forest Modelling. 

# Load the random forest library.

library(randomForest)

# Read the dataset into variables that we'll use.

train_data <- read.csv("~/Documents/R Studio/Titanic/train.csv", header = TRUE)
head(train_data)

test_data <- read.csv("~/Documents/R Studio/Titanic/test.csv", header = TRUE)
head(test_data)

# Exploratory look at women's survival rate.

# Get the total number of women on the Titanic
total_women <- sum (train_data$Sex == 'female')

# Get the total number of women who survived
survived_women <- sum(train_data[which(train_data$Sex == 'female'), "Survived"])
rate_women = survived_women/total_women

paste("% of women who survived:", rate_women *100)

# Compare women's survival rate to men's survival rate.

# Get the total number of men on the Titanic
total_men <- sum (train_data$Sex == 'male')

# Get the total number of men who survived
survived_men <- sum(train_data[which(train_data$Sex == 'male'), "Survived"])
rate_men = survived_men/total_men

paste("% of Men who survived:", rate_men *100)

#Use insights above to generate modelling to predict, compare and select best survival rate amongst 
#the ticket class, sex, number of siblings/ spouse aboard and number of parents/ children aboard.

fit <- randomForest(as.factor(Survived) ~ Pclass + Sex + SibSp + Parch, data=train_data,
                    proximity = TRUE,
                    ntree = 2000)

pred <- predict(fit, test_data)
submission <- data.frame(PassengerId = test_data$PassengerId, Survived = pred)
write.csv(submission, file = "submission.csv", row.names = FALSE)
paste("Your submission was sucessfully saved!")