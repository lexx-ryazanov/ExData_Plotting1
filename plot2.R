# Use English locale
Sys.setlocale("LC_TIME", "English")

# load all data from file
data <- read.table(file = "household_power_consumption.txt", 
                 sep = ";", header = TRUE, na.strings = c("?"),
                 stringsAsFactors = FALSE)

# get subset data, for particular date
subdata <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007", ]

# combine Date and Time colunms together
subdata$DateTime <- as.POSIXct(paste(subdata$Date, subdata$Time), format="%d/%m/%Y %H:%M:%S") 

# use .png file as output device
png(filename = "plot2.png", width=480, height=480, units="px")

# build a chart
plot(x = subdata$DateTime, y = subdata$Global_active_power, 
     xlab = "",
     ylab = "Global Active Power (kilowatts)",
     type="l")

# Don't forget to close the PNG device!
dev.off()