library(lubridate)

data <- read.table("household_power_consumption.txt", sep = ";", header = T, stringsAsFactors = F)


data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data$full_date <- paste0(data$Date, " " , data$Time)
data$full_date <- as_datetime(data$full_date)
#This creates a full day/time column and converts it to POSIXct object

dataset <- data[which(data$Date %in% as.Date(c("2007-02-01", "2007-02-02"))),] 
#We will be using data from the dates 1 and 2 of February 2007

energy_columns <- grepl("Sub_metering", colnames(dataset), fixed=F)
dataset[,energy_columns] <- lapply(dataset[,energy_columns], function(x) {as.numeric(x)})
#Converts class of column energy sub metering to numeric


#Next we plot the line plot with axes Energy sub metering and weekdays
png(filename="plot3.png", width=480, height = 480 )


with(dataset, plot(Sub_metering_1~full_date, type='l', col = "black", xlab = "", ylab="Energy sub metering" ))

with(dataset, lines(Sub_metering_2~full_date, col = "red", xlab = "", ylab="Energy sub metering" ))


with(dataset, lines(Sub_metering_3~full_date, col = "blue", xlab = "", ylab="Energy sub metering" ))

#This adds legend in the right top corner
legend("topright", legend=c(colnames(dataset[,energy_columns])), col= c("black", "red", "blue"), lwd = 1, cex=0.75)

dev.off()