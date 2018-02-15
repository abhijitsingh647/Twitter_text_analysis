setwd("__")

# Read the dictionary of positive and negative words
pos.words = readLines("pos_words.txt") # positive dictionary
head(pos.words)
neg.words = readLines("neg_words.txt") # negative dictionary
head(neg.words)

# Read the data/ tweets
SampText =read.csv("NestleTweetsSample.csv")

# Check total rows and some sample tweets
nrow(SampText)
head(SampText)

source("Sentiment_Score_Function.R") 
# Loads the function in R's memory/ workspace
scores = score.sentiment(SampText[,2], pos.words, neg.words)
View(scores)

# See the extent of Negatives and Positives
summary(scores[,1])
# 
# 
# 
# 



# Let us write a loop to create an additional column in the scores 
# dataset to store sentiments depending on the score values
# Some rules to be followed:
# If a score is-
# 0 => "Neutral"
# Bet. 0 and 1 => "Positive"
# 2 and above => "Joy"
# Bet. 0 and -1 => "Negative"
# -2 and below => "Anger"
# 
# 
# 
# 
# 
# 
# 
# 

# Nested if else. You can look at switch casing too
for(i in 1:nrow(scores))
{
  if(scores[i,1] > 0 & scores[i,1] < 2)
  {
    scores$Sentiment[i] = "Positive"
  }
  else if(scores[i,1] < 0 & scores[i,1] > -2)
  {
    scores$Sentiment[i] = "Negative"
  }
  else if(scores[i,1] <= -2)
  {
    scores$Sentiment[i] = "Anger"
  }
  else if(scores[i,1] >= 2)
  {
    scores$Sentiment[i] = "Joy"
  }
  else
  {
    scores$Sentiment[i] = "Neutral"
  }
}

View(scores)

# Plotting
barplot(height = table(scores$Sentiment))

# Divide the graphical canvas/window into 4 sub-windows
# windows()
# par(mfrow = c(2,2))

# Sorted (default) barplot
barplot(height = sort(table(scores$Sentiment)))

# Decreasing barplot
barplot(height = sort(table(scores$Sentiment), decreasing = T))

# Decreasing barplot with some existing color palettes 
barplot(height = sort(table(scores$Sentiment), decreasing = T), 
        col = rainbow(n = 5))

# Decreasing barplot with some existing color palettes
barplot(height = sort(table(scores$Sentiment), decreasing = T), 
        col = terrain.colors(n = 5))

# Write the sentiment analysis to file on hard disk
write.csv(scores, "NestleSentimentScores.csv", row.names=F)

# In case you would like one plot per chart, then do the following and 
# run AGAIN all the 4 barplot codes above to generate the plots one by one
# par(mfrow = c(1,1))

