#Download and read the file
temp <- tempfile()
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = temp, mode = "wb")
fileUnzipped <- unzip(temp)
data <- read.table("/Users/marissatroiano-yang/Desktop/Coursera/household_power_consumption.txt", stringsAsFactors = FALSE, header = TRUE, sep = ";")
unlink(temp)

#subset for 2007-02-01 and 2007-02-02
dataSubset <- subset(data, data$Date == "1/2/2007" | data$Date == "2/2/2007")

#change global active power to numeric class
dataSubset$Global_active_power <- as.numeric(dataSubset$Global_active_power)

#new variable datetime with date and time combined
datetime <- strptime(paste(dataSubset$Date, dataSubset$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")

#launch graphic device
png(filename = "plot2.png")

#Create plot that uses lines
plot(datetime, globalActivePower, type = "l", xlab = "",ylab = "Global Active Power (kilowatts)")
dev.off()

