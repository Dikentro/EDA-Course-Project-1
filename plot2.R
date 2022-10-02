library(lubridate)

data <- read.table("household_power_consumption.txt", sep = ";", header = T, stringsAsFactors = F)


data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data$full_date <- paste0(data$Date, " " , data$Time)
data$full_date <- as_datetime(data$full_date)
#This creates a full day/time column and converts it to POSIXct object

dataset <- data[which(data$Date %in% as.Date(c("2007-02-01", "2007-02-02"))),] 
#We will be using data from the dates 1 and 2 of February 2007

dataset$Global_active_power <- as.numeric(dataset$Global_active_power)
#This changes the column Global_active_power to numeric


#Next we will plot a line plot with axes Global Active Power and weekdays
png(filename="plot2.png", width=480, height = 480 )

with(dataset, plot(Global_active_power~full_date, type='l', 
                            xlab = "", ylab="Global Active Power (kilowatts)" ))

dev.off()