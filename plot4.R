#Download and read the file
temp <- tempfile()
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = temp, mode = "wb")
fileUnzipped <- unzip(temp)
data <- read.table("/Users/marissatroiano-yang/Desktop/Coursera/household_power_consumption.txt", stringsAsFactors = FALSE, header = TRUE, sep = ";")
unlink(temp)

#subset for 2007-02-01 and 2007-02-02
dataSubset <- subset(data, data$Date == "1/2/2007" | data$Date == "2/2/2007")

#new variable datetime with date and time combined
datetime <- strptime(paste(dataSubset$Date, dataSubset$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")

#change global active power to numeric class
dataSubset$Global_active_power <- as.numeric(dataSubset$Global_active_power)

#change submetering groups to numeric class
dataSubset$Sub_metering_1 <- as.numeric(dataSubset$Sub_metering_1)
dataSubset$Sub_metering_2 <- as.numeric(dataSubset$Sub_metering_2)
dataSubset$Sub_metering_3 <- as.numeric(dataSubset$Sub_metering_3)

#change voltage column to numeric class
dataSubset$Voltage <- as.numeric(dataSubset$Voltage)

#change global reactive power to numeric
dataSubset$Global_reactive_power <- as.numeric(dataSubset$Global_reactive_power)

#launch graphic device
png(filename = "plot4.png")

#plot 
par(mfrow = c(2, 2))
with(dataSubset, {
  plot(datetime, globalActivePower, type = "l", xlab = "",ylab = "Global Active Power (kilowatts)")
  plot(datetime, dataSubset$Voltage,col = "black", type = "l", xlab = "datetime", ylab = "Voltage")
  
  plot(datetime, dataSubset$Sub_metering_1,col = "black", type = "l", xlab = "", ylab = "Energy sub metering")
  lines(datetime, Sub_metering_2, col = "red", type = "l")
  lines(datetime, Sub_metering_3, col = "blue", type = "l")
  legend("topright", lty = 1, lwd = 2, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"))
  
  plot(datetime, dataSubset$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_readctive_power")
  })
dev.off()

