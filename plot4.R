## Plot 4 - Energi submetering

## set filename, fetch data and unzip data
dataurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
localzip <- "local_data_zip.zip"
localunzip <- "local_data"
if (!file.exists(localzip)) { file.create (localzip) }
download.file (dataurl, localzip)
unzip (localzip, exdir = localunzip)

## read in data, select 2007-02-01 and 2007-02-02 into plotData and release memory
datafilepath <- paste (localunzip, "/", "household_power_consumption.txt", sep ="" )
allReadings <- read.table(datafilepath, na.strings = "?", sep = ";", header = TRUE, stringsAsFactors = FALSE)
plotData <- subset(allReadings, Date == "1/2/2007" | Date == "2/2/2007")
rm(allReadings)

## add a column with POSIXct times (mutate does not like POSIXlt) 
plotData2 <- mutate (plotData, posTime = as.POSIXct( strptime (paste (Date, Time, sep = " "), format = "%e/%m/%Y %T")))
## Find max values for sub metering to set up plot size correctly (y-axis)
maxSub= max (plotData2$Sub_metering_1, plotData2$Sub_metering_2, plotData2$Sub_metering_3)

## plot 4: 4 separate line plots 2X2. Start by opening the device and defining the grid
bmp (filename = "plot4.bmp")
par(mfrow= c(2,2)) 

## plot 1
with (plotData2, plot(posTime, Global_active_power, main="", xlab ="", ylab ="Global Active Power", type="l"))
## plot 2
with (plotData2, plot(posTime, Voltage, main="", xlab ="datetime", ylab ="Voltage", type="l"))
## plot 3
with (plotData2, plot(posTime, Sub_metering_1, ylim = c(0, maxSub), main="", xlab ="", ylab ="", type="n"))
with (plotData2, lines(posTime, Sub_metering_1, col ="black"))
with (plotData2, lines(posTime, Sub_metering_2, col ="red"))
with (plotData2, lines(posTime, Sub_metering_3, col="blue"))
title (ylab = "Energy sub metering")
legend("topright", c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1), col=c("black","red", "blue"), cex = .8, bty="n")
## plot 4
with (plotData2, plot(posTime, Global_reactive_power, main="", xlab ="datetime", type="l"))

dev.off()

