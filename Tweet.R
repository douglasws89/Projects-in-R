# Put the keys tokens obtained from Twitter
consumerKey = 'd2vj2pCuLuuFqAZRjECs4vVos';
consumerSecret = '961LJqWfu6LmfZv3bdlnQ8U6cuJsY3AoAx1RDgyYNzBP1ThGBv';
accessToken = '54984475-JrxSTrRs8X6tVUYONyClRXP5qMWUc368Fur83helD';
accessSecret = 'NbD7Zp9RbVbphgCK3HNxCpGy3bagNNpYnP9qF67LSeU9v';

#Now set up twitter
setup_twitter_oauth(consumerKey,consumerSecret, accessToken, accessSecret)

#Search most recent tweets foa a specific hashtag
tweets = searchTwitter('sanders',n=200)

#Convert tweets to a vector
text1 = sapply(tweets, function(x) x$getText())

#Clean up the data
#Remove retweets
text1 = gsub("(RT|via)((?:\\b\\W*@\\w+)+)", "", text1)

#Remove @ people
text1 = gsub("@\\w+", "", text1)

#Remove punctuation
text1 = gsub("[[:punct:]]", "", text1)

#Remove numbers
text1 = gsub("[[:digit:]]", "", text1)

#Remove html links
text1 = gsub("http\\w+","", text1)

#Remove unnecessary spaces
text1 = gsub("[ \t] {2,}", "", text1)
text1 = gsub("^\\s+|\\s+$", "", text1)

#Remove any specific words we want to get rid of
remove.words = c('and', 'the', 'to', 'for', 'if', 'of','now','how','who','for','from','and',
                 'this','has','its','not', 'with', 'did', 'too', 'this', 'are')

for(word in remove.words){
  string = paste0("\\b", word, "\\b")
  text1 = gsub(string, "", text1)
}

text1 <- iconv(text1,to="utf-8-mac")

#Put the list of tweets in a format that wordcloud() can recognize
corpus = Corpus(VectorSource(text1))
tdm = TermDocumentMatrix(corpus)
m = as.matrix(tdm)

# get word counts in decreasing order
word_freqs = sort(rowSums(m), decreasing = TRUE)
# create a data frame with wods and their frequencies
dm = data.frame(word=names(word_freqs), freq=word_freqs)

#Now make a wordloud of the top 100 wods
include = 100 #How many words do we want in the wordcloud?
wordcloud(dm$word[1:include], dm$freq[1:include], random.order = FALSE,
          colors = brewer.pal(8, "Dark2"))

