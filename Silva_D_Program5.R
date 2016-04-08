#map(database='legacy_world');
#map(database='state');
#map(database='county',region='CO')

# Import data and create variables
#Par(mar=c(1,1,1,1))
# Import table and save in variable data
data = read.table('GDP_EPC_2010.csv', header = TRUE, sep=',')

# Assign the gdp that is within the data to a varaible gdp
gdp = data$GDP
# assign epc as well
epc = data$EPC 
# read country names and save them at country.names
country.names = data$Country 
# read latitude and longitude and save them at variables lat and long
lat = data$Lat 
long = data$Long 

# Modify coutntry names so it plots
# Make country names match the ones on the table
map.names = levels(country.names)
map.names[map.names == 'Russia'] = 'USSR'
map.names[map.names == 'United States'] = 'USA'

# Map 1
#Create blus color scheme
gdp.min = min(gdp)
gdp.max = max(gdp)
gdp.normalized = (gdp - gdp.min)/ (gdp.max - gdp.min) #Turns GDP into values between 0 and 1
gdp.col = hsv(2/3, gdp.normalized,1) #Normalized values correspond to saturation

# Plot all countries in grey
map(database = 'legacy_world', bg = 'azure', fill = TRUE, col = 'grey90') #Plot all countries in grey, fill background with azure

# Add Title
title('World GDP 2010 - More Saturated Blue Corresponds to Higuer GDP')

# Add countries to plot using a for loop
# for loop reads each country on the table and adds collor to them
for(i in 1:length(map.names)){
	map(database = 'legacy_world', regions= map.names[i],
		add = T, fill=TRUE, col = gdp.col[i])
} 

# Add a scale
map.scale(90, -50, metric=FALSE)

# Map 2 - Add to GDP Map
#Create Red/Green color scheme
epc.col = rep(0, length(epc))

epc.cutoff = median(epc) #Highest value foa a 'low' epc
epc.col[epc<=epc.cutoff] = 'green' # Color for low epc
epc.col[epc > epc.cutoff] = 'red' # Color for high epc

# Add border to plot using a for loop
# par(lwd = 2) #Thicker borders
# for (i in 1:length(map.names)){
# 	map(database = 'legacy_world', regions = map.names[i], add = T, fill = FALSE, col = epc.col[i]) # Fill is false so col gives border coloor
# }

par(lwd = 1) #Change back to default value

#Add a legend
legend.text = c('EPC < 65 Million BTUs/Person', 'EPC >= 65 Million BTUs/Person')
legend.col = c('green','red')
legend(-170,-50,legend.text,col = legend.col,lty=1)

# Create Red/Green divergent color scheme
epc.col.2 = rep(0, length(epc))
epc.cutoff = median(epc) # Highest value for 'low' epc

# partition in two sets since we are using two divergent colors Red and green
epc.low = epc[epc <= epc.cutoff]
epc.high = epc[epc > epc.cutoff] # Partition into 2 sets

#Sets high EPC values to shades of Red
epc.col.2[epc <= epc.cutoff] = hsv(1/3, 1-(epc.low - min(epc.low))/ (epc.cutoff - min(epc.low)), 1) 

#Sets low EPC values to shades of Red
epc.col.2[epc > epc.cutoff] = hsv(1, (epc.high - epc.cutoff) / (max(epc.high) - epc.cutoff), 1) 

#Plot Circles
epc.radii = sqrt(epc/pi)
symbols(data$Long, data$Lat, circles = epc.radii, add = T, inches = 0.3, bg = epc.col.2)