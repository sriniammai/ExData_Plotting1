library(dplyr)
if(!file.exists("household_power_consumption.txt")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = 'hpc.zip')
  unzip('hpc.zip','household_power_consumption.txt')
}
hpcComplete <- read.table("household_power_consumption.txt",header = TRUE, sep = ';',na.strings = '?',stringsAsFactors = FALSE)
hpcSubset <- hpcComplete %>% 
             filter(Date %in% c('1/2/2007','2/2/2007'))  %>%
             mutate(DateTime = as.POSIXct(strptime(paste(Date,Time,sep=" "),format = "%d/%m/%Y %H:%M:%S"))) 

png('plot4.png',width = 480, height = 480)                
par(mfrow=c(2,2))
plot(hpcSubset$DateTime,hpcSubset$Global_active_power, type = 'l', xlab = '',ylab = "Global Active Power")

plot(hpcSubset$DateTime,hpcSubset$Voltage, type = 'l', xlab = 'datetime',ylab = "Voltage")

plot(hpcSubset$DateTime, hpcSubset$Sub_metering_1, type = 'l', xlab = '',ylab = "Energy sub metering")
lines(hpcSubset$DateTime, hpcSubset$Sub_metering_2,type = 'l', col='red')
lines(hpcSubset$DateTime, hpcSubset$Sub_metering_3,type = 'l', col='blue')
legend("topright",legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),col=c('black','red','blue'),lty=1,bty = 'n')

plot(hpcSubset$DateTime,hpcSubset$Global_reactive_power, type = 'l', xlab = 'datetime',ylab='Global_reactive_power')

dev.off()