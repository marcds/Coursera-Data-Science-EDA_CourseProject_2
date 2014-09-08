# Load libraries
library(plyr)
library(data.table)

# Read files
PM25 <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Convert into data.table
PM25.DT <- data.table(PM25)
SCC.DT <- data.table(SCC)

# Filter on “24510”
PM25.24510 <- PM25[which(PM25$fips == "24510"), ]

# Aggregate emissions by year
tot.emissions.baltimore <- with(PM25.24510, aggregate(Emissions, by = list(year), sum))

# Rename columns
colnames(tot.emissions.baltimore) <- c("year", "Emissions")

# Second Plot: Baltimore emissions using R base plotting
plot(tot.emissions.baltimore$year, tot.emissions.baltimore$Emissions, type = "b", pch = 18, col = "green", ylab = "Emissions", xlab = "Year", main = "Baltimore Emissions")

# Save plot
dev.copy(png, file = "plot2.png", width = 480, height = 480)

# Close the PNG device
dev.off()