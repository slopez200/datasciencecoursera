plot3 <- function()
{
  library(dplyr)
  
  plotData <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE)
  
  # remove data that we aren't interested in
  plotData <- plotData[plotData$Date == "1/2/2007" | plotData$Date == "2/2/2007",]
  
  #print(plotData$Sub_metering_2)
  
  smallerPlotData <- plotData %>% select(Date,Time,Sub_metering_1,Sub_metering_2,Sub_metering_3)
  
  smallerPlotData <- mutate(smallerPlotData, dateTime=paste(smallerPlotData$Date, smallerPlotData$Time, sep=" "))
  
  #convert the date/time to a date/time R understands
  smallerPlotData$dateTime <- as.POSIXct(smallerPlotData$dateTime,format="%d/%m/%Y %H:%M:%S")
  
  # convert the date to a date that R understands
  smallerPlotData$Date <- as.POSIXct(smallerPlotData$Date,format="%d/%m/%Y")
  
  smallerPlotData$Sub_metering_1 <- as.numeric(as.character(smallerPlotData$Sub_metering_1))
  smallerPlotData$Sub_metering_2 <- as.numeric(as.character(smallerPlotData$Sub_metering_2))
  smallerPlotData$Sub_metering_3 <- as.numeric(as.character(smallerPlotData$Sub_metering_3))
  
  png(filename = "plot3.png", width=480, height=480, units = "px")
  plot(smallerPlotData$dateTime, smallerPlotData$Sub_metering_1, type = "l", ylab = "Energy sub metering",xlab="")
  lines(smallerPlotData$dateTime, smallerPlotData$Sub_metering_2,type="l",col="red")
  lines(smallerPlotData$dateTime, smallerPlotData$Sub_metering_3,type="l",col="blue")
  
  legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lwd=1)
  dev.off()
  
  
}