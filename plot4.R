#Read data from household_power_consumption.txt"
EPC_data <- read.table("household_power_consumption.txt",skip=1,sep=";")
names(EPC_data) <-c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
head(EPC_data)
subEPC_data <- subset(EPC_data, EPC_data$Date == "1/2/2007" | EPC_data$Date == "2/2/2007")

subEPC_data$Date <- as.Date(subEPC_data$Date, format="%d/%m/%Y")
subEPC_data$Time <- strptime(subEPC_data$Time, format="%H:%M:%S")
subEPC_data[1:1440,"Time"] <- format(subEPC_data[1:1440,"Time"],"2007-02-01 %H:%M:%S")
subEPC_data[1441:2880,"Time"] <- format(subEPC_data[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

#plot4
par(mfrow = c(2,2))

attach(subEPC_data)
plot(Time, as.numeric(Global_active_power), type="l", xlab=" ", ylab="Global Active Power")

plot(Time, as.numeric(Voltage), type="l", xlab="datetime", ylab="Voltage")

plot(Time, Sub_metering_1, type="n", xlab="",ylab="Energy sub metering")
lines(Time, as.numeric(Sub_metering_1))
lines(Time, as.numeric(Sub_metering_2),col="red")
lines(Time, as.numeric(Sub_metering_3),col="blue")
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)

plot(Time, as.numeric(Global_reactive_power), type="l",xlab="datetime", ylab="Global_reactive_power")
