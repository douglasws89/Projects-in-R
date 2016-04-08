epc = read.table('EPC2005.csv', header = TRUE, sep=',');
gdp = read.table('GDP2005.csv', header = TRUE, sep=',');
pop = read.table('POP2005.csv', header = TRUE, sep=',');

epc.2005 = epc$X2005;
gdp.2005 = gdp$X2005;
pop.2005 = pop$X2005;

#epc.million.2005 = epc.2005 
gpc.2005 = gdp.2005/pop.2005 
#gdppercapta.thousands.2005 = gdppercapta.2005*(10^3) # Fix this values

# Plot the scatter plot and assign labels
plot((gpc.2005), (epc.2005), 
     las = 1,
     xlab = 'GDP per Capita (Thousands of US Dollars)',
     ylab = 'EPC (Energy Consumption per Capita in Million BTUs)',
     main = 'Total EPC by GDP per Capita',
     cex.axis = 0.75)

abline(h = seq(0,350,by = 50), lty = 2, col = 'grey');
abline(v = seq(0, 50, by = 5), lty = 2, col = 'grey');

# Plots the degression line
abline(lm(epc.2005 ~ gpc.2005), col = 'red');

epc.2005.max = max(epc.2005)

arrows(x1 = 43,
       y1 = epc.2005.max,
       x0 = 38,
       y0 = epc.2005.max);

# Label Countries with the Names
text(33, 
     epc.2005.max,
     labels = 'Highest EPC', cex = 0.50);

