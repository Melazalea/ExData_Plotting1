#raw data file url address
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

#if not already downloaded, download raw data to the working directory and unzip it
if (!file.exists("powerConsumption.zip")) {
  download.file(fileUrl, destfile = paste0(getwd(), "/powerConsumption.zip"))
}
unzip(paste0(getwd(), "/powerConsumption.zip"), exdir = paste0(getwd(), "/unzippedPowerConsumption"))

#read the data into a dataframe
power <- read.table(paste0(getwd(), "/unzippedPowerConsumption/household_power_consumption.txt"), sep = ";", header =TRUE,stringsAsFactors = FALSE)

#subset the data to limit to only the two days of interest
powerSubset = subset(power, Date == "1/2/2007" | Date == "2/2/2007")

#Convert global active power to a numeric
powerSubset$Global_active_power = as.numeric(powerSubset$Global_active_power)

#open the graphics device
png(file = "plot1.png", width=480, height = 480)

#adjust margins and create the plot
par(mar=c(4,4,1,1))
hist(powerSubset$Global_active_power, col = "red", breaks = 15, xlab="Global Active Power (kilowatts)", main = "Global Active Power", ylim = c(0,1200))

#close the graphics device
dev.off()