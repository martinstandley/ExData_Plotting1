## Histogram 1: this script fetches a file with energy usage, unzips it and then produces a histrogram
## og Global Active Power usage for 2 of the days that were measured.
library(dplyr)

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

## plot 1: make histogram of Global Active Power as plot1.bmp (size 480*480 is default)
png (filename = "plot1.png")
hist(plotData$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()

