# load all data from file
data <- read.csv(file = "household_power_consumption.txt", 
                 sep = ";", header = TRUE, na.strings = c("?"))

# get subset data, for particular date
subdata <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007", ]

# use .png file as output device
png(filename = "plot1.png", width=480, height=480, units="px")

# i want lesser axis labels
par(cex = 0.75)

# build a histogram
hist(subdata$Global_active_power, 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", 
     col = "red")

# Don't forget to close the PNG device!
dev.off()