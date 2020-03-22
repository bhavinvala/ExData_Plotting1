# Create directory named expana(abbreviated Exploratory Data Analysis)
#if (!dir.exists("./expana")) {
#  dir.create('./expana')
#}
#Set Working Directory;
#setwd("./expana")

#Download the file if not already downloaded;
if (!file.exists("./exdata_data_household_power_consumption.zip")) {
  download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip',destfile="exdata_data_household_power_consumption.zip")  
}

#Unzip the file;
if (!file.exists('./household_power_consumption.txt')) {
  unzip("exdata_data_household_power_consumption.zip")  
}

#Read the data and subset for 1st-2nd Feb2007 data;
dt<-read.delim("household_power_consumption.txt",sep=";")
dt$Date_N<-as.Date(as.character(dt$Date),"%d/%m/%Y")

dt2<-subset(dt,as.Date("2007-02-01","%Y-%m-%d")<= Date_N & Date_N<=as.Date("2007-02-02","%Y-%m-%d"))
rm(dt)

#Create Required variables to plot;
dt2$Global_active_power<-as.numeric(as.character(dt2$Global_active_power))
dt2$Voltage<-as.numeric(as.character(dt2$Voltage))
dt2$Global_reactive_power<-as.numeric(as.character(dt2$Global_reactive_power))
dt2$datetime<-strptime(paste(dt2$Date,dt2$Time),"%d/%m/%Y %H:%M:%S")

#set the 2 row 2 column for plot, arrange margins;
par(mfrow=c(2,2),mar=c(4,4,1,1))

#Plot
png(file="plot4.png",height=480,width=480,units="px");
#1-Topleft plot
with(dt2,plot(datetime,Global_active_power,ylab="Global Active Power (kilowatts)",xlab=' ',type='n'))
with(dt2,lines(datetime,Global_active_power))
#2 Topright plot
with(dt2,plot(datetime,Voltage,ylab="Voltage",xlab='datetime',type='n'))
with(dt2,lines(datetime,Voltage))

#3 Bottomleft Plot
with(dt2,plot(datetime,Sub_metering_1,ylab="Energy Sub metering",xlab=' ',type='n'))
with(dt2,lines(datetime,Sub_metering_1,col="black"))
with(dt2,lines(datetime,Sub_metering_2,col="red"))
with(dt2,lines(datetime,Sub_metering_3,col="blue"))
legend("topright",lty=1,col=c("black","red","blue"),legend=c("sub_metering_1","sub_metering_2","sub_metering_3"),bty='n')

#4 Bottomright Plot
with(dt2,plot(datetime,Global_reactive_power,xlab='datetime',type='n'))
with(dt2,lines(datetime,Global_reactive_power))
dev.off()
#End of Program;