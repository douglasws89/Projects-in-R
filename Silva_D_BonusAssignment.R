# Import library htmltab
library(htmltab)

# Saves website in the variable theurl
theurl = "https://en.wikipedia.org/wiki/List_of_countries_by_GDP_%28nominal%29"

# Gets the table 1 of the website
#htmltab(theurl,i);
i = 2
datatable = htmltab(theurl,i);

# Gets data in the table to be ploted and saves it in variables country and gdp
country = datatable$Country
gdp = datatable$GDP

# GDP is originally as string. Convert it into numbers
gdp = as.numeric(gsub(",", "", gdp))

# GDP is in millions, pass it to trillions.
gdp.trillion = gdp/10^6

# Range does not include two first indexes which are World and E.U.
indexrange = 3:17

# Creates the Barplot
barplot(gdp.trillion[indexrange], names = country[indexrange], las = 2,
        ylab = 'US Dollars (Trillions)', main = 'Top 15 Countries by GDP. \n Ranking by International Monetary Fund',
        )`
# Edits the plot margin
par(mar=(c(7,6,3,3)))