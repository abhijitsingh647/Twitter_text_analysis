setwd("__")

# Some R to twitter setup related information 
# http://thinktostart.com/twitter-authentification-with-r/

library(twitteR)

### This is a constant obtained from settings in twitter: dev.twitter.com/apps (or apps.twitter.com)
my_consumer_Key = "Your Consumer Key"

### This is a constant obtained from settings in twitter: dev.twitter.com/apps (or apps.twitter.com)
my_consumer_Secret = "Your Consumer Secret"

# Authentication to Twitter
setup_twitter_oauth(consumer_key = my_consumer_Key, 
                    consumer_secret = my_consumer_Secret)

# # If the above does not work, then additionally use access token and access key (after generating it from your twitter app)
# ### This is a constant obtained from settings in twitter: dev.twitter.com/apps (or apps.twitter.com)
# my_access_token = "Your Key"
# ### This is a constant obtained from settings in twitter: dev.twitter.com/apps (or apps.twitter.com)
# my_access_secret = "Your Consumer Secret"
# 
setup_twitter_oauth(consumer_key = my_consumer_Key,
                    consumer_secret = my_consumer_Secret,
                    access_token = "3224454618-orfYpKbJwvCQCEPgmVdvHQJn8x9Ouj4zAg9nZAH",
                    access_secret = "UgM4dQnrLea8ra7lZFCBWlFPKQf8s9G8bzngjc3RM94O6")


# And you can start extracting tweets from Twitter
RF_Tweets = searchTwitter(searchString = "#Federer", lang = "en")
RF_Tweets

RF_Tweets_DF = twListToDF(RF_Tweets)
View(RF_Tweets_DF)

# # Write the tweets to a file
write.csv(RF_Tweets_DF, "RF_Tweets_DF.csv", row.names = F)
