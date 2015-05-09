#raw data file url address
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

#if not already downloaded, download raw data to the working directory and unzip it
if (!file.exists("powerConsumption.zip")) {
  download.file(fileUrl, destfile = paste0(getwd(), "/powerConsumption.zip"))
}
unzip(paste0(getwd(), "/powerConsumption.zip"), exdir = paste0(getwd(), "/unzippedPowerConsumption"))


#read the data into a dataframe
power <- read.table(paste0(getwd(), "/unzippedPowerConsumption/household_power_consumption.txt"), sep = ";", header =TRUE,stringsAsFactors = FALSE)


#Limit the data to the two days of interest
powerSubset = subset(power, Date == "1/2/2007" | Date == "2/2/2007")


#Combine the Date and time columns and convert them to POSIXlt datetime class
powerSubset$DateTime = paste(powerSubset$Date, powerSubset$Time)
powerSubset$DateTime = strptime(powerSubset$DateTime, "%d/%m/%Y %H:%M:%S")


#Convert the requird variables to numerics
powerSubset$Global_active_power = as.numeric(powerSubset$Global_active_power)
powerSubset$Global_reactive_power = as.numeric(powerSubset$Global_reactive_power)
powerSubset$Voltage = as.numeric(powerSubset$Voltage)
powerSubset$Sub_metering_1 = as.numeric(powerSubset$Sub_metering_1)
powerSubset$Sub_metering_2 = as.numeric(powerSubset$Sub_metering_2)
powerSubset$Sub_metering_3 = as.numeric(powerSubset$Sub_metering_3)


#open the graphics device
png("plot4.png")


#format for four plots
par(mfrow=c(2,2))


#First plot of four:day versus global active power(same as plot 2)
plot(powerSubset$DateTime, powerSubset$Global_active_power, type="l",xlab= "", ylab="Global Active Power")


#Second plot of four: day versus Voltage
plot(powerSubset$DateTime, powerSubset$Voltage, type="l",xlab= "datetime", ylab="Voltage")


#Third plot of four: day versus energy sub metering (similar to plot3)
plot(powerSubset$DateTime, powerSubset$Sub_metering_1, type="l",xlab= "", ylab="Energy sub metering")
legend("topright", bty="n", lty="solid", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"))
lines(powerSubset$DateTime, powerSubset$Sub_metering_2, type="l",xlab= "", col = "red")
lines(powerSubset$DateTime, powerSubset$Sub_metering_3, type="l",xlab= "", col = "blue")


#First plot of four:day versus global reactive power
plot(powerSubset$DateTime, powerSubset$Global_reactive_power, type="l",xlab= "datetime", ylab="Global_reactive_power")


#close the graphics device
dev.off()