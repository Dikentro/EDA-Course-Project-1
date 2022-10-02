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

power_columns <- grepl("Sub_metering", colnames(dataset), fixed=F)
dataset[,power_columns] <- lapply(dataset[,power_columns], function(x) {as.numeric(x)})
dataset$Voltage <- as.numeric(dataset$Voltage)
#Converts class of columns Global Active Power, Global Rective Power and Voltage to numeric

#We begin the plotting
png(filename="plot4.png", width=480, height = 480 )


par(mfrow=c(2,2))
#This changes par to accomodate 4 plots in 2 rows and 2 columns

#Axes with Global Active power and Weekday-Time
with(dataset, plot(Global_active_power~full_date, type='l', xlab = "", ylab="Global Active Power (kilowatts)" ))

#Axes with Voltage and Weekday-Time
with(dataset, plot(Voltage~full_date, type='l', xlab = "datetime"))


#Axes with Energy submetering and Weekday-time
with(dataset, plot(Sub_metering_1~full_date, type='l', col = "black", xlab = "", ylab="Energy sub metering" ))

with(dataset, lines(Sub_metering_2~full_date, col = "red", xlab = "", ylab="Energy sub metering" ))


with(dataset, lines(Sub_metering_3~full_date, col = "blue", xlab = "", ylab="Energy sub metering" ))

# adding legend in the right top corner
legend("topright", legend=c(colnames(dataset[,energy_columns])), bty = "n",
       col= c("black", "red", "blue"), lwd = 1, cex=0.8)

#Axes with Global re-ctive power and Weekday-Time
with(dataset, plot(Global_reactive_power~full_date, type='l', xlab = "datetime"))



dev.off()