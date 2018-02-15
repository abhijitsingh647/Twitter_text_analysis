setwd("")
Tweets <- read.csv("", header = T)
str(Tweets)

#Build Corpus
library(tm)
corpus <- iconv(Tweets$text, to = "utf-8-mac")
corpus <- Corpus(VectorSource(corpus))
inspect(corpus[1:5])

#Clean Text
corpus <- tm_map(corpus, tolower)
inspect(corpus[1:5])
corpus <- tm_map(corpus, removePunctuation)

corpus <- tm_map(corpus, removeNumbers)
Cleanset <- tm_map(corpus, removeWords, stopwords('english'))
inspect(Cleanset[1:50])

removeURL <- function(x) gsub('http[[:alnum:]]*','',x)

Cleanset <- tm_map(Cleanset, content_transformer(removeURL))

Cleanset <- tm_map(Cleanset, stripWhitespace)

#Term Document Matrix

TDM <- TermDocumentMatrix(Cleanset)
TDM <- as.matrix(TDM)
TDM[1:10, 1:20]

#Bar Plot
W <- rowSums(TDM)
W <- subset(W, W>=25)
barplot(W,
        las = 2,
        col = rainbow(50))
#Word Cloud
library(wordcloud)
W <- sort(rowSums(TDM), decreasing = TRUE)
set.seed(222)
wordcloud(words = names(W),freq = W,
          max.words = 500,
          random.order = F,
          min.freq = 2,
          colors = brewer.pal(8,'Dark2'),
          scale = c(7,.8),
          rot.per = 0.3)
#Sentiment Analysis

library(lubridate)
library(syuzhet)
library(ggplot2)
library(scales)
library(reshape2)
library(dplyr)

#Read File
Tweets <- read.csv("/Users/rocket/Documents/BA/Twitter_Analysis/RF_Tweets_DF.csv", header = T)
Tweets2 <- iconv(Tweets$text, to = "utf-8-mac")

#obtain Sentiment Score
S <- get_nrc_sentiment(Tweets2)
head(S)
S
Tweets2[3]
get_nrc_sentiment('salute')

#Bar Plot
barplot(colSums(S),
        las = 2,
        col = rainbow(10),
        ylab = 'count',
        main = 'Sentiment Score for Kejriwal Government')

