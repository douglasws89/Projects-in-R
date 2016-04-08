# Loads the EPC file into the variable epc. Header checks to see if the file has the 
# name of the variable in as its first line. Set it to True means that the first row
# contains one fewer than the number of columns. The sep argument gets the separation 
# character for the file.
# If the file name was EPC2000210.csv, the code would be
# epc = read.table('EPC20002010.cvs', header = TRUE, sep =',');
epc = read.table('EPC_2000_2010.csv', header = TRUE, sep=',');
# Loads the POP file into the variable pop.
pop = read.table('Pop_2000_2010.csv', header = TRUE, sep=',');
# The $ character allows us to access an specific field within the variable. For instance,
# in this code we are getting the field X2010 of the variables epc and pop, and placing 
# content into the variables epc.2010 and pop.2010 respectively.
epc.2010 = epc$X2010; 
pop.2010 = pop$X2010;
# The .csv format is the format understood by R by default.
energy.2010 = epc.2010 * pop.2010;
barplot(energy.2010);
# We use epc$Country to get all the values stored in the Country field of the variable epc
barplot(energy.2010, names = epc$Country, main = 'Total Energy Consumption - 2010');

