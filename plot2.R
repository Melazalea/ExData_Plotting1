#raw data file url address
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

#if not already downloaded, download raw data to the working directory and unzip it
if (!file.exists("powerConsumption.zip")) {
  download.file(fileUrl, destfile = paste0(getwd(), "/powerConsumption.zip"))
}
unzip(paste0(getwd(), "/powerConsumption.zip"), exdir = paste0(getwd(), "/unzippedPowerConsumption"))

#read the data into a dataframe
power <- read.table(paste0(getwd(), "/unzippedPowerConsumption/household_power_consumption.txt"), sep = ";", header =TRUE,stringsAsFactors = FALSE)

#limit the data set to only the two days of interest
powerSubset = subset(power, Date == "1/2/2007" | Date == "2/2/2007")

#Combine the Date and time columns and convert them to POSIXlt datetime class
powerSubset$DateTime = paste(powerSubset$Date, powerSubset$Time)
powerSubset$DateTime = strptime(powerSubset$DateTime, "%d/%m/%Y %H:%M:%S")

#Convert global active power to numeric
powerSubset$Global_active_power = as.numeric(powerSubset$Global_active_power)

#open the graphics device
png("plot2.png")

#create the plot
plot(powerSubset$DateTime, powerSubset$Global_active_power, type="l",xlab= "", ylab="Global Active Power (kilowatts)")

#close the graphics device
dev.off()