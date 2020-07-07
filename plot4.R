#Set working directory to where data is housed, read in data, subset only imporant dates
setwd("~/Data Science Specialization/Exploratory Data Analysis/ExData_Plotting1/")
library(dplyr)
power_data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)
feb_first <- subset(power_data, Date == "1/2/2007")
feb_second <- subset(power_data, Date == "2/2/2007")
feb_data <- rbind(feb_first, feb_second)
feb_data <- mutate(feb_data, DateTime = paste(feb_data$Date, " ", feb_data$Time))
feb_data$DateTime <- strptime(feb_data$DateTime, "%d/%m/%Y %H:%M:%S")
feb_data <- feb_data[, -c(1, 2)]
feb_data <- select(feb_data, DateTime, everything())
feb_data[, 2:7] <- sapply(feb_data[, 2:7], as.numeric)

#Construct the plot
png("plot4.png")
par(mfrow = c(2, 2))
plot(feb_data$DateTime, feb_data$Global_active_power, type = "l", xlab = " ",
     ylab = "Global Active Power (kilowatts)")
plot(feb_data$DateTime, feb_data$Voltage, type = "l", xlab = "datetime",
     ylab = "Voltage")
plot(feb_data$DateTime, feb_data$Sub_metering_1, type = "l", ylab = "Energy sub metering",
     xlab = "")
lines(feb_data$DateTime, feb_data$Sub_metering_2, col = "red")
lines(feb_data$DateTime, feb_data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1, box.lty = 0)
plot(feb_data$DateTime, feb_data$Global_reactive_power, type = "l", xlab = "datetime",
     ylab = "Global_reactive_power")
dev.off()

