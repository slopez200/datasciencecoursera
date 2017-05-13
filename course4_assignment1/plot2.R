plot2 <- function()
{
  library(dplyr)
  
  plotData <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE)
  
  # remove data that we aren't interested in
  plotData <- plotData[plotData$Date == "1/2/2007" | plotData$Date == "2/2/2007",]
  
  smallerPlotData <- plotData %>% select(Date,Time,Global_active_power)
  
  smallerPlotData <- mutate(smallerPlotData, dateTime=paste(smallerPlotData$Date, smallerPlotData$Time, sep=" "))

  smallerPlotData$dateTime <- strptime(smallerPlotData$dateTime,format="%d/%m/%Y %H:%M:%S")
  
  smallerPlotData$Global_active_power = as.numeric(as.character(smallerPlotData$Global_active_power))

  png(filename = "plot2.png", width=480, height=480, units = "px")
  
  plot(smallerPlotData$dateTime, smallerPlotData$Global_active_power, type = "l", xlab="", ylab="Global Active Power (kilowatts)")
  
  dev.off()
}