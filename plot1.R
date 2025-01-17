library(dplyr)
if(!file.exists("household_power_consumption.txt")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = 'hpc.zip')
  unzip('hpc.zip','household_power_consumption.txt')
}
hpcComplete <- read.table("household_power_consumption.txt",header = TRUE, sep = ';',na.strings = '?',stringsAsFactors = FALSE)
hpcSubset <- hpcComplete %>% filter(Date %in% c('1/2/2007','2/2/2007')) %>% select("Global_active_power")
png(file='plot1.png',width = 480,height = 480)
hist(hpcSubset$Global_active_power, main = 'Global Active Power', xlab = 'Global Active Power (killowats)', col = 'red')
dev.off()
