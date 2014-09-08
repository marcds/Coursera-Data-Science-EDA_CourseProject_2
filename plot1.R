# Load libraries
library(plyr)
library(data.table)

# Read files
PM25 <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Convert into data.table
PM25.DT = data.table(PM25)
SCC.DT = data.table(SCC)

# Aggreate emission per year
tot.emissions <- with(PM25, aggregate(Emissions, by = list(year), sum))

# First Plot: Emission per year using R base plotting
plot(tot.emissions, type = "b", pch = 18, col = "green", ylab = "Emissions",  xlab = "Year", main = "Annual Emissions")

# Save plot
dev.copy(png, file = "plot1.png", width = 480, height = 480)

# Close the PNG device
dev.off()