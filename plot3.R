# Use English locale
Sys.setlocale("LC_TIME", "English")

# load all data from file
data <- read.csv(file = "household_power_consumption.txt", 
                 sep = ";", header = TRUE, na.strings = c("?"))

# get subset data, for particular date
subdata <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007", ]

# combine Date and Time colunms together
subdata$DateTime <- as.POSIXct(paste(subdata$Date, subdata$Time), format="%d/%m/%Y %H:%M:%S") 

# use .png file as output device
png(filename = "plot3.png", width=480, height=480, units="px")

# build a chart
with(subdata, {
  plot(x = DateTime, y = Sub_metering_1, 
       xlab = "",
       ylab = "Energy sub metering",
       type="l")
  
  lines(x = DateTime, y = Sub_metering_2, 
       type="l",
       col="red")
  
  lines(x = DateTime, y = Sub_metering_3, 
        type="l",
        col="blue")
})

legend("topright", 
       c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), 
       col=c("black", "red", "blue"), 
       lty=1)

# Don't forget to close the PNG device!
dev.off()