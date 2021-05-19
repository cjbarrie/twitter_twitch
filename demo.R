# title: academicTwitteR Demo
# author: Christopher Barrie and Justin Chun-ting Ho
# date: 20/05/2021



####################### Setup #######################

install.packages("academictwitteR")
library(academictwitteR)

bearer_token <- "AAAAAAAAAAAAAAAAAAAA............." # Insert bearer token



####################### Main Functions ####################### 

user_tweets <- get_user_tweets("TwitterDev",
                               "2020-05-01T00:00:00Z",
                               "2020-05-18T00:00:00Z",
                               bearer_token)

search_tweets <- get_all_tweets("#Covid",
                                "2020-05-18T09:00:00Z",
                                "2020-05-18T09:10:00Z",
                                bearer_token)

View(search_tweets)



####################### Getting Full RT Rext ####################### 

# Note some of the RT texts are truncated
head(search_tweets$text)

search_tweets$referenced_tweets[4]



#######################  Getting Usernames ####################### 

# Note the function only returns user ID (but not screen name etc)
authors <- search_tweets$author_id[1:10]
authors_profile <- get_user_profile(authors, bearer_token)
names(authors_profile)



#######################  Building Queries (Using the build_query() function) ####################### 

build_query("#Covid", is_retweet = FALSE, has_images = TRUE)

# you can read the documentation here
?build_query

# arguments can be passed directly to
search_tweets <- get_all_tweets("#Covid",
                                "2020-05-18T09:00:00Z",
                                "2020-05-18T09:10:00Z",
                                bearer_token,
                                is_retweet = FALSE,
                                has_images = TRUE)



#######################  Storing as JSONs ####################### 

search_tweets <- get_all_tweets("#Covid",
                                "2020-05-18T09:00:00Z",
                                "2020-05-18T09:30:00Z",
                                bearer_token,
                                data_path = "covid_tweets",
                                is_retweet = FALSE,
                                has_images = TRUE)

search_tweets <- bind_tweet_jsons(data_path = "covid_tweets")

View(search_tweets)

# Tips: you can set bind_tweets to FALSE if you are saving the data as JSONs


#######################  Interrupted Collection ####################### 

search_tweets <- get_all_tweets("#Covid",
                                "2020-05-18T09:00:00Z",
                                "2020-05-18T09:30:00Z",
                                bearer_token,
                                data_path = "more_covid_tweets")

resume_collection(data_path = "more_covid_tweets", 
                  bearer_token = bearer_token, 
                  bind_tweets = FALSE)

search_tweets <- bind_tweet_jsons(data_path = "more_covid_tweets")
