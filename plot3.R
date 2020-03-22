
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

#create required variables to plot;
dt2$datetime<-strptime(paste(dt2$Date,dt2$Time),"%d/%m/%Y %H:%M:%S")
dt2$Sub_metering_1<-as.numeric(as.character(dt2$Sub_metering_1))
dt2$Sub_metering_2<-as.numeric(as.character(dt2$Sub_metering_2))
dt2$Sub_metering_3<-as.numeric(as.character(dt2$Sub_metering_3))

#plot
png(file="plot3.png",height=480,width=480,units="px");
with(dt2,plot(datetime,Sub_metering_1,ylab="Energy Sub metering",xlab=' ',type='n'))
with(dt2,lines(datetime,Sub_metering_1,col="black"))
with(dt2,lines(datetime,Sub_metering_2,col="red"))
with(dt2,lines(datetime,Sub_metering_3,col="blue"))
legend("topright",lty=1,col=c("black","red","blue"),legend=c("sub_metering_1","sub_metering_2","sub_metering_3"))
dev.off()
#End of Program