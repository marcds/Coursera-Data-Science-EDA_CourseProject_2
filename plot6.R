# Load libraries
library(plyr)
library(ggplot2)
library(data.table)


# Read files
PM25 <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Convert into data.table
PM25.DT = data.table(PM25)
SCC.DT = data.table(SCC)

# Subset emissions due to motor vehicle sources from 'NEI' for Los Angeles
# and combine it with the data from Baltimore
emissionLA <- PM25[PM25$SCC %in% SCC$SCC & PM25$fips == "06037", ]
emissionBalt <- PM25[PM25$SCC %in% SCC$SCC & PM25$fips == "24510", ]
emissions <- rbind(emissionBalt, emissionLA)

# Calculate the emissions due to motor vehicles in Baltimore and Los Angeles for every year
tot.Emissions <- aggregate(Emissions ~ fips * year, data = emissions, FUN = sum)
tot.Emissions$county <- ifelse(tot.Emissions$fips == "06037", "Los Angeles", "Baltimore")

## Setup ggplot with data frame
plot <- qplot(y = Emissions, x = year, data = tot.Emissions, color = county)

## Add layers
plot + scale_x_continuous(breaks = seq(1999, 2008, 3)) + theme_bw() + geom_point(size = 3) + 
      geom_line() + labs(y = expression("Motor  Vehicle Related " * PM[2.5] * " Emissions (in tons)")) + labs(x = "Year") + 
      labs(title = expression("Motor  Vehicle Related " * PM[2.5] * " Emissions in Baltimore & Los Angeles (1999 - 2008)")) + 
      theme(axis.text = element_text(size = 8), axis.title = element_text(size = 14),  
      plot.title = element_text(vjust = 2, hjust = 0.17, size = 12), legend.title = element_text(size = 11)) + scale_colour_discrete(name = "County")

# Save plot
dev.copy(png, file = "plot6.png", width = 480, height = 480)

# Close the PNG device
dev.off()