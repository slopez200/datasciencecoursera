plot1 <- function()
{
  library(dplyr)
  
  plotData <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE)
  
  # remove data that we aren't interested in
  plotData <- plotData[plotData$Date == "1/2/2007" | plotData$Date == "2/2/2007",]
  
  smallerPlotData <- plotData %>% select(Date,Global_active_power)
  
  smallerPlotData$Date <- strptime(smallerPlotData$Date,format="%d/%m/%Y")

  png(filename = "plot1.png", width=480, height=480, units = "px")
  
  hist(as.numeric(as.character(smallerPlotData$Global_active_power)), col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
  
  dev.off()
  
}