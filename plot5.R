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

# Get Baltimore emissions from motor vehicle sources
balt.emissions <- PM25.DT[(PM25.DT$fips=="24510") & (PM25.DT$type=="ON-ROAD"),]
balt.emissions.aggr <- aggregate(Emissions ~ year, data=balt.emissions, FUN=sum)

# Open Plot device and save plot
png("plot5.png")

# Plot
ggplot(balt.emissions.aggr, aes(x=factor(year), y=Emissions)) +
  geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression("total PM"[2.5]*" emissions")) +
  ggtitle("Motor Vehicle PM2.5 Emissions in Baltimore City")

# Close plot device
dev.off()
