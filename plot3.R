dataread <- read.table('F:/Coursera/household_power_consumption.txt',sep = ";")

#X <- read.table(pipe('F:/Coursera/household_power_consumption.txt'),header = TRUE)

colnames(dataread) <- as.character(unlist(dataread[1,]))
dataread = dataread[-1, ]

library(dplyr)

required_data = dataread %>% filter(Date== '1/2/2007' | Date == '2/2/2007')

FullTimeDate <- strptime(paste(required_data$Date, required_data$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
required_data <- cbind(required_data, FullTimeDate)

required_data$Date <- as.Date(required_data$Date, format="%d/%m/%Y")
required_data$Time <- format(required_data$Time, format="%H:%M:%S")
required_data$Global_active_power <- as.numeric(required_data$Global_active_power)
required_data$Global_reactive_power <- as.numeric(required_data$Global_reactive_power)
required_data$Voltage <- as.numeric(required_data$Voltage)
required_data$Global_intensity <- as.numeric(required_data$Global_intensity)
required_data$Sub_metering_1 <- as.numeric(required_data$Sub_metering_1)
required_data$Sub_metering_2 <- as.numeric(required_data$Sub_metering_2)
required_data$Sub_metering_3 <- as.numeric(required_data$Sub_metering_3)


png("plot3.png", width=480, height=480)
with(required_data, plot(FullTimeDate, Sub_metering_1, type="l", xlab="Day", ylab="Energy sub metering"))
lines(required_data$FullTimeDate, required_data$Sub_metering_2,type="l", col= "red")
lines(required_data$FullTimeDate, required_data$Sub_metering_3,type="l", col= "blue")
legend(c("topright"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty= 1, lwd=2, col = c("black", "red", "blue"))
dev.off()