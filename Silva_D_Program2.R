# Loads data from tables. Saves the data into two variables: inc for Income.csv and col for College.csv
inc = read.table('Income.csv', header=TRUE, sep=',');
col = read.table('College .csv', header=TRUE, sep=',');
# Gets data for specific columns of the tables. 
# inc.2015 gets the data for the second column, that holds the Household income values,
# by using the $ character.
inc.2015 = inc$Household.Income;
# Same thing happens for Some college vlues.
col.2015 = col$X..Some.College;
# Scatter Plot's the data with the values of the variables inc.2015 in the x-axis and col.2015 in the y-axis
plot(inc.2015, col.2015, xlab = 'Median Household Income in US Dollars' , ylab = '% Some College');
