stock = "CMG"
start.month = 2 #0-11 covers Jan-Dec
start.day = 01 # 1-31 covers 32 days in a month
start.year = 2014
end.month = 02
end.day = 6
end.year = 2016

theurl = paste0("http://real-chart.finance.yahoo.com/table.csv?",
              	"&s=", stock,
              	"&a=", start.month,
              	"&b=", start.day,
              	"&c=", start.year,
              	"&d=", end.month,
              	"&e=", end.day,
              	"&f=", end.year,"&ignore=.csv")

theurl

#Now read in
stock.data = read.table(theurl, header = TRUE, sep = ',')
names(stock.data) #Look at the columns we have

#Extract the variables we want to plot 
date = as.Date(stock.data$Date)
close = stock.data$Close

plot(date, close, type='l', main='Closing Price of CMG (Chipotle)',
	ylim = c(0, max(close)), xlab = '', ylab = 'Price (US Dollars)')

## Now annotate

#http://www.cdc.gov/ecoli/2015/o26-11-15/
x.0 = as.Date("2015-10-19")
y.0 = 500
arrows(x.0,y.0,x.0,y.0+200)
text(x.0, y.0, 'First e coli cases')

#https://public.health.oregon.gov/newsadvisories/Pages/ecoli-chiplote.aspx
x.1 = as.Date("2015-10-31")
y.1 = 250

arrows(x.1,y.1,x.1,y.1+350)
text(x.1, # Year-moth-date
	y.1, "Outbreak linked to Chipotle by Oregon Department of Public Health")

#http://www.reuters.com/article/us-chipotle-mexican-lawsuit-idUSKB0UM2BD20160108
x.2 = as.Date("2016-01-08")
y.2 = 650

arrows(x.2, y.2, x.2, y.2 - 200)
text(x.2, y.2, "Food safety lawsuit")

