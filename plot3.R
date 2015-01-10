# Use English locale
Sys.setlocale("LC_TIME", "English")

zipFileName <- "dataset.zip"
dataFileName <- "dataset.data"

if(file.exists(dataFileName)){
  cat("Found cached dataset.\n")
  load(dataFileName)
} else {
  cat("Downloading file... Please, wait\n")
  download.file(
    url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
    destfile = zipFileName)
  
  cat("Unzipping\n")
  unzip(zipFileName)
  
  cat("Loading data from file\n")
  data <- read.table(file = "household_power_consumption.txt", 
                     sep = ";", header = TRUE, na.strings = "?")
  
  # get subset data, for particular date
  data <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007", ]
  
  # combine Date and Time colunms together
  data$datetime <- as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")
  
  cat("Saving cache\n")
  save(file = dataFileName, data)
}

# use .png file as output device
png(filename = "plot3.png", width=480, height=480, units="px")

cat("Building chart. File: plot3.png\n")
with(data, {
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
})

legend("topright", 
       c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), 
       col=c("black", "red", "blue"), 
       lty=1)

# Don't forget to close the PNG device!
dev.off()