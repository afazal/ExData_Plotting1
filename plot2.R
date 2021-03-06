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


## plot globalactivepower vs date&time
png("plot2.png", width=480, height=480)
with(required_data, plot(FullTimeDate, Global_active_power, type="l", xlab="Day", ylab="Global Active Power (kilowatts)"))
dev.off()