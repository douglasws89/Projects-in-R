# Selects the title/table of the stock
stock = "PBR"
#Selects range by entering start and end day-month-year
start.month = 6 #0-11 covers Jan-Dec
start.day = 01 # 1-31 covers 32 days in a month
start.year = 2014
end.month = 05
end.day = 5
end.year = 2015

# Creates a string with the URL of the page passing the json parameters 
theurl = paste0("http://real-chart.finance.yahoo.com/table.csv?",
                "&s=", stock,
                "&a=", start.month,
                "&b=", start.day,
                "&c=", start.year,
                "&d=", end.month,
                "&e=", end.day,
                "&f=", end.year,"&ignore=.csv")

# Prints the URL final string
theurl

#Now read in
# Calls the server passing the string with the parameters
# Reads the table and saves it in the variabel stock.data
stock.data = read.table(theurl, header = TRUE, sep = ',')

#Look at the columns we have
names(stock.data) 

#Extract the variables we want to plot 
#Saves the dates in the variable date
date = as.Date(stock.data$Date)

# Is is the closing price of each day
close = stock.data$Close

# plots the data passing the values and the labels for x and y axis
plot(date, close, type='l', main='Closing Price of PBR (Petrobras)',
     ylim = c(0, max(close)), xlab = '', ylab = 'Price (US Dollars)')

## Now annotate

#http://www.reuters.com/article/us-brazil-election-oil-analysis-idUSKBN0GX1P020140902
# creates arrow and title for the first date on a high
x.2 = as.Date("2014-09-02")
y.2 = 10
arrows(x.2, y.2, x.2, y.2 + 6)
text(x.2, y.2-2, "President Declares \nOil 'Bonanza'")

#http://www.wsj.com/articles/brazil-prosecutors-charge-another-former-petrobras-executive-1418668373
# Creates the arrow for a low, second date
x.0 = as.Date("2014-12-15")
y.0 = 18
arrows(x.0,y.0,x.0,y.0 - 9)
text(x.0, y.0+2, 'Another former Petrobras\nExecutive Charged on Scandal')

#http://oilprice.com/Energy/Crude-Oil/Petrobras-Scandal-Goes-Far-Deeper-Than-Previously-Thought.html
# Creates arrow for low, third date
x.1 = as.Date("2015-03-13")
y.1 = 10
arrows(x.1,y.1,x.1,y.1-4)
text(x.1, # Year-moth-date
     y.1+2, "Scandal goes far deeper\n than previously expected")



