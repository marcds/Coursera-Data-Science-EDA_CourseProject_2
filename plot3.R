# Load libraries
library(plyr)
library(ggplot2)
library(data.table)

# Read files
PM25 <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Convert into data.table
PM25.DT <- data.table(PM25)
SCC.DT <- data.table(SCC)

# Aggregate Emissions by year, county, type and filter “24510”
tot.emissions.balt.type <- ddply(PM25.24510, .(type, year), summarize, Emissions = sum(Emissions))

tot.emissions.balt.type$Pollutant_Type <- tot.emissions.balt.type$type

# Plot emissions per year grouped by source type using ggplot2 plotting system point, nonpoint, onroad, nonroad. POINT type has seen increased emissions until year 2005 and then decreased.
qplot(year, Emissions, data = tot.emissions.balt.type, group = Pollutant_Type, 
      color = Pollutant_Type, geom = c("point", "line"), ylab = expression("Total Emissions, PM"[2.5]), 
      xlab = "Year", main = "Total Emissions in U.S. by Type of Pollutant")

# Save plot
dev.copy(png, file = "plot3.png", width = 480, height = 480)

# Close the PNG device
dev.off()