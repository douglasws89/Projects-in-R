#Graph
# Read the continent Table and saves it in the continents variable
continents = read.table('Continents.csv', header = TRUE, sep = ',')

# Read columns from the table. gets the Names and Symbols and saves them into the 
# continent.names and continents.symbol.
continent.names = c('Africa', 'Asia', 'Europe', 'North America', 'South America');
continent.symbols = c(21,22,23,24,5);

# Creates a variable for country symbols
country.symbols = rep(0, length(continents$Country));

# Loops trough the table and relates the country names with the symbols 
for(i in 1:length(continent.symbols)){
  country.symbols[continents$Continent == continent.names[i]] = 
    continent.symbols[i];
}

# Scale the data into trillion for gdp, and quadrillion for energy.
energy.2010 = epc.2010 * pop.2010
gdp.trillion.2010 = gdp.2010/10^12
energy.quad.2010 = energy.2010/10^9

# Plots the relation, the labels, and the symbols.
plot((gdp.trillion.2010), (energy.quad.2010), 
     pch = country.symbols,
     las = 1,
     xlab = 'GDP in Trillions of Dollars',
     ylab = 'Total Energy in Quadrillion BTUs',
     main = 'Total Energy by GDP: 2010',
     cex.axis = 0.75)

# Plot the grid lines vertical and horizontal
abline(h = seq(0,110,by = 10), lty = 2);
abline(v = seq(0, 25, by = 1), lty = 2);

# Plots the degression line
abline(lm(energy.quad.2010 ~ gdp.trillion.2010));

# Order the country by energy
energy.order = order(energy.2010, decreasing = TRUE);

# Labels Brics and the US
country.names = c('United States','Brazil', 'Russia', 'China','India', 'South Africa');
country.pos = match(country.names, gdp$Country);

# Set arrows on Brics and the US
arrows(x1 = gdp.trillion.2010[country.pos],
       y1 = energy.quad.2010[country.pos],
       x0 = gdp.trillion.2010[country.pos],
       y0 = energy.quad.2010[country.pos] + 10);

# Label Countries with the Names
text(gdp.trillion.2010[country.pos], 
     energy.quad.2010[country.pos],
     labels = country.names);

