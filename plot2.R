## Plot 2 - This sccript fetches an energy usage data set, washes it and produces a plot for 2 days 
## Global Active Power
library (dplyr)

## set filename, fetch data and unzip data
dataurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
localzip <- "local_data_zip.zip"
localunzip <- "local_data"
if (!file.exists(localzip)) { file.create (localzip) }
download.file (dataurl, localzip)
unzip (localzip, exdir = localunzip)

## read in data, select 2007-02-01 and 2007-02-02 into plotData and release memory
datafilelocation <- paste (localunzip, "/", "household_power_consumption.txt", sep ="" )
allReadings <- read.table(datafilelocation, na.strings = "?", sep = ";", header = TRUE, stringsAsFactors = FALSE)
plotData <- subset(allReadings, Date == "1/2/2007" | Date == "2/2/2007")
rm(allReadings)

## add a column with POSIXct times (mutate does not like POSIXlt) 
plotData2 <- mutate (plotData, posTime = as.POSIXct( strptime (paste (Date, Time, sep = " "), format = "%e/%m/%Y %T")))

## plot 2: make plot of Global Active Power as plot2.bmp (size 480*480 is default)
png (filename = "plot2.png")
with (plotData2, plot(posTime, Global_active_power, main="", xlab ="", ylab ="", type="n"))
with (plotData2, lines(posTime, Global_active_power))
title (ylab = "Global Active Power (kilowatts)")
dev.off()

