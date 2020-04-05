setwd('J:/Jishnu')

#pulling data
data <- read.table('household_power_consumption.txt', stringsAsFactors = F, sep = ";", na.strings = "?", header = T)

#checking the data
head(data)

#checking the structure of dataset
str(data)

#Converting the Date comlumn to Date type
data$Date <- as.Date(data$Date, "%d/%m/%Y")

#filtering data from feb 1 2007 to feb 2 2007
data <- subset(data,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

#removing incomplete data
data <- data[complete.cases(data),]

#checking for NA's in data
table(is.na(data))

#Combining date and time column
Date_Time <- paste(data$Date, data$Time)

library(dplyr)

#removing date and time column
data <- select(data, -Date)
data <- select(data, -Time)

#adding Date_Time column to data
data$Date_Time <- Date_Time

#Formatting Date_Time column
data$Date_Time <- as.POSIXct(Date_Time)

#creating plot
with(data, {
  plot(Sub_metering_1~Date_Time, type='l', ylab='Energy Sub Metering', col='black', xlab='')
  lines(Sub_metering_2~Date_Time, col='red')
  lines(Sub_metering_3~Date_Time, col='blue')
})

#creating legend
legend('topright', col= c('black', 'red', 'blue'), lwd=c(1, 1, 1), c('sub_metering_1', 'sub_metering_2', 'sub_metering_3'))


#Saving file and closing device
dev.copy(png, 'plot3.png', height=480, width=480)
dev.off()