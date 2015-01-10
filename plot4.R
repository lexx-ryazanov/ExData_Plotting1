# Use English locale
Sys.setlocale("LC_TIME", "English")

# load all data from file
data <- read.csv(file = "household_power_consumption.txt", 
                 sep = ";", header = TRUE, na.strings = c("?"))

# get subset data, for particular date
subdata <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007", ]
subdata$datetime <- as.POSIXct(paste(subdata$Date, subdata$Time), format="%d/%m/%Y %H:%M:%S") 

# use .png file as output device
png(filename = "plot4.png", width=480, height=480, units="px")

# prepare frame
par(mfrow = c(2, 2))

with(subdata,{
  
  # chart #1
  plot(x = datetime, y = Global_active_power, 
       xlab = "",
       ylab = "Global Active Power",
       type="l")
  
  # chart #2
  plot(x = datetime, y = Voltage, 
       type="l")
  
  # chart #3
  plot(x = datetime, y = Sub_metering_1, 
       xlab = "",
       ylab = "Energy sub metering",
       type="l")
  
  lines(x = datetime, y = Sub_metering_2, 
        type="l",
        col="red")
  
  lines(x = datetime, y = Sub_metering_3, 
        type="l",
        col="blue")
  
  legend("topright", 
         c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), 
         col=c("black", "red", "blue"), 
         lty=1, bty="n")
  
  # chart #4
  plot(x = datetime, y = Global_reactive_power, 
       type="l")
  
})


# Don't forget to close the #PNG device!
dev.off()