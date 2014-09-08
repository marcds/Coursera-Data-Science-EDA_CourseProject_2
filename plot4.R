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

# Get SCC codes for coal combustion related surces from SCC.Level.Three variable
coal.scc <- SCC.DT[grep("Coal", SCC.Level.Three), SCC]

# Aggregate Emissions for the above SCC by year
coal.emissions <- PM25.DT[SCC %in% coal.scc, sum(Emissions), by = "year"]
colnames(coal.emissions) <- c("year", "Emissions")

# Plot emissions per year using ggplot2 plotting system. Emissions from coal combustion related sources decreased significantly from 1999-2008.
plot <- ggplot(coal.emissions, aes(year, Emissions))
plot + geom_point(color = "red") + geom_line(color = "green") + labs(x = "Year") + 
  labs(y = expression("Total Emissions, PM"[2.5])) + labs(title = "Emissions from Coal Combustion for the US")

# Save plot
dev.copy(png, file = "plot4.png", width = 480, height = 480)

# Close the PNG device
dev.off()