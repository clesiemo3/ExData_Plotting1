library("data.table")
loadFebData <- function(){
    input <- "household_power_consumption.txt" 
    #file is found in this zip file: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
    numLines <- 48 * 60 # total number of minutes in 48 hours, total number of rows to read in
    colNames <- c("Date"
                  ,"Time"
                  ,"Global_active_power"
                  ,"Global_reactive_power"
                  ,"Voltage"
                  ,"Global_intensity"
                  ,"Sub_metering_1"
                  ,"Sub_metering_2"
                  ,"Sub_metering_3")
    dt <- fread(input,sep=";",data.table=T,na.strings="?",skip="1/2/2007",nrows=numLines,header=F,col.names=colNames)
    return(dt)
}
dt <- loadFebData()
png(filename="plot1.png",width=480,height=480)
hist(dt$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
dev.off()
