plot4 <- function()
{
  library(dplyr)
  
  # read the data for all functions
  plotData <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE)
  
  # remove data that we aren't interested in
  plotData <- plotData[plotData$Date == "1/2/2007" | plotData$Date == "2/2/2007",]
  
  # create a new column for the combined date/time
  plotData <- mutate(plotData, dateTime=paste(plotData$Date, plotData$Time, sep=" "))
  
  #convert the date/time to a date/time R understands
  plotData$dateTime <- as.POSIXct(plotData$dateTime,format="%d/%m/%Y %H:%M:%S")
  
  # convert the date to a date that R understands
  plotData$Date <- as.POSIXct(plotData$Date,format="%d/%m/%Y")

  # create the png file
  png(filename = "plot4.png", width=480, height=480, units = "px")
  
  # create a 2 X 2 display of the plots
  par(mfrow=c(2,2))
  
  # execute the plots
  plot2(plotData)
  voltagePlot(plotData)
  plot3(plotData)
  powerPlot(plotData)
  
  # turn off the file output stream
  dev.off()
  
}

plot2 <- function(plotData)
{
  smallerPlotData <- plotData %>% select(dateTime,Global_active_power)
  
  smallerPlotData$Global_active_power = as.numeric(as.character(smallerPlotData$Global_active_power))
  
  plot(smallerPlotData$dateTime, smallerPlotData$Global_active_power, type = "l", xlab="", ylab="Global Active Power")
  
  
}

voltagePlot <- function(plotData)
{
  smallerPlotData <- plotData %>% select(dateTime,Voltage)
  
  smallerPlotData$Voltage = as.numeric(as.character(smallerPlotData$Voltage))
  
  plot(smallerPlotData$dateTime, smallerPlotData$Voltage, type = "l", xlab="datetime", ylab="Voltage")
  
  
}

powerPlot <- function(plotData)
{
  smallerPlotData <- plotData %>% select(dateTime,Global_reactive_power)
  
  smallerPlotData$Global_reactive_power = as.numeric(as.character(smallerPlotData$Global_reactive_power))
  
  plot(smallerPlotData$dateTime, smallerPlotData$Global_reactive_power, type = "l", xlab="datetime", ylab="Global_reactive_power")
  
  
}
  
plot1 <- function(plotData)
{
  smallerPlotData <- plotData %>% select(Date,Global_active_power)
  
  smallerPlotData$Date <- strptime(smallerPlotData$Date,format="%d/%m/%Y")
  
  hist(smallerPlotData$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
  
}



plot3 <- function(plotData)
{
  smallerPlotData <- plotData %>% select(dateTime,Sub_metering_1,Sub_metering_2,Sub_metering_3)
  
  smallerPlotData$Sub_metering_1 = as.numeric(as.character(smallerPlotData$Sub_metering_1))
  smallerPlotData$Sub_metering_2 = as.numeric(as.character(smallerPlotData$Sub_metering_2))
  smallerPlotData$Sub_metering_3 = as.numeric(as.character(smallerPlotData$Sub_metering_3))
  
  plot(smallerPlotData$dateTime, smallerPlotData$Sub_metering_1, type = "l", ylab = "Energy sub metering",xlab="")
  lines(smallerPlotData$dateTime, smallerPlotData$Sub_metering_2,type="l",col="red")
  lines(smallerPlotData$dateTime, smallerPlotData$Sub_metering_3,type="l",col="blue")
  
  legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lwd=1)
  
  
}