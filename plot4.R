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
dateTime <- paste(dt$Date,dt$Time)
dateTime <- strptime(dateTime,"%d/%m/%Y %H:%M:%S")
png(filename="plot4.png",width=480,height=480)
par(mfrow=c(2,2))
#plot1-top left
plot(dateTime,dt$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")

#plot2-top right
plot(dateTime,dt$Voltage,type="l",ylab="Voltage",xlab="datetime")

#plot3-bottom left
plot(dateTime,dt$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
points(dateTime,dt$Sub_metering_1,col="black",type="l")
points(dateTime,dt$Sub_metering_2,col="red",type="l")
points(dateTime,dt$Sub_metering_3,col="blue",type="l")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1),col=c("black","red","blue"),bty="n")

#plot4-bottom right
plot(dateTime,dt$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")

dev.off()
