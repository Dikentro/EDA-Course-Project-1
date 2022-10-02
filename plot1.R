data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", 
                   colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

data$Date <- as.Date(data$Date, "%d/%m/%Y")
#this sets the class of data as date

dataset <- data[which(data$Date %in% as.Date(c("2007-02-01", "2007-02-02"))),]
#we will be using data for the days 1 and 2 of February 2007

dataset$Global_active_power <- as.numeric(dataset$Global_active_power)
#this sets the column Global_active_power as numeric

png(filename="plot1.png", width=480, height = 480 ) #this function plots the histogram
par(las=1)
hist(dataset$Global_active_power, xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency", main = "Global Active Power", col = "red")
dev.off() #completes plotting

