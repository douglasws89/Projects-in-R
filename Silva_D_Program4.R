# Import the data
epc = read.table('EPC_2000_2010.csv', header = TRUE, sep=',');
pop = read.table('Pop_2000_2010.csv', header = TRUE, sep=',');
gdp = read.table('GDP_2000_2010.csv', header = TRUE, sep=',');
continents = read.table('Continents.csv', header=TRUE, sep=',')

# Organazing the data to variables
# Saving columns from the tables into variables
epc.2010 = epc$X2010; 
pop.2010 = pop$X2010;
gdp.2010 = gdp$X2010;
#extract names of countries
country.names = continents$Country 

#Corresponding continents
country.continents = continents$Continent

#Calculate Total Energy
energy.2010 = epc.2010 * pop.2010 

# Assign collors to continets
continent.palette = c('Pink', 'Yellow', 'Blue', 'Orange', 'Green')
# Assign continent names
continent.names = c('Africa', 'Asia', 'Europe', 'North America', 'South America');

# Create an array of colors the size of total countries
country.colors = rep(0, length(gdp.2010))

# Populate the array according to country names. 
# Each country gets one collor according to what continent it is in.
for(i in 1:length(continent.names)){
  country.colors[continents$Continent == continent.names[i]] = 
    continent.palette[i];
}

# Scale the data into trillion for gdp, and quadrillion for energy.
energy.2010 = epc.2010 * pop.2010
gdp.trillion.2010 = gdp.2010/(10^12)
energy.quad.2010 = energy.2010/(10^9)

# Plot the scatter plot and assign labels
plot((gdp.trillion.2010), (energy.quad.2010), 
     las = 1,
     xlab = 'GDP in Trillions of Dollars',
     ylab = 'Total Energy in Quadrillion BTUs',
     main = 'Total Energy by GDP: 2010',
     cex.axis = 0.75)

# Creates vertical and horizontal gridlines
abline(h = seq(0,110,by = 10), lty = 2, col = 'grey');
abline(v = seq(0, 25, by = 1), lty = 2, col = 'grey');

# Creates the country symbols according to population size
# And plots the symbols with colors and size.
pop.radii = sqrt(pop.2010/pi)
symbols(gdp.trillion.2010, energy.quad.2010, pop.radii*2, add = TRUE, inches = 0.4, bg = country.colors)

# Adds legends of continents and its correspondent colors
legend(0,100,continent.names,fill = continent.palette)

# Plots the degression line
abline(lm(energy.quad.2010 ~ gdp.trillion.2010));

# Order the country by energy
energy.order = order(energy.2010, decreasing = TRUE);

# Labels Brics and the US
country.names = c('United States','Brazil', 'Russia', 'China','India', 'South Africa');
country.pos = match(country.names, gdp$Country);

# Label Countries with the Names
text(gdp.trillion.2010[country.pos], 
     energy.quad.2010[country.pos],
     labels = country.names);

