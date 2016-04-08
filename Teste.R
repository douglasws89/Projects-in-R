epc = read.table('EPC_2000_2010.csv', header = TRUE, sep=',');
pop = read.table('Pop_2000_2010.csv', header = TRUE, sep=',');
epc.2010 = epc$X2010; 
pop.2010 = pop$X2010;
energy.2010 = epc.2010 * pop.2010;
barplot(energy.2010);
barplot(energy.2010, names = epc$Country, main = 'Total Energy Consumption - 2010');

