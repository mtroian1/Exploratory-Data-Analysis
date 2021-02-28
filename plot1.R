#Download and read the file
temp <- tempfile()
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = temp, mode = "wb")
fileUnzipped <- unzip(temp)
data <- read.table("/Users/marissatroiano-yang/Desktop/Coursera/household_power_consumption.txt", stringsAsFactors = FALSE, header = TRUE, sep = ";")
unlink(temp)

#change data column from character to date class
data$Date <- as.Date(data$Date, format = "%d/%m/%Y") 

#subset for 2007-02-01 and 2007-02-02
dataSubset <- subset(data, data$Date == "2007-02-01" | data$Date == "2007-02-02")

#change global active power to numeric class
globalActivePower <- as.numeric(dataSubset$Global_active_power)

#launch graphic device
png(filename = "plot1.png")

#plot histogram of global active power for those 2 days, red,
hist(globalActivePower, freq = TRUE, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.off()

