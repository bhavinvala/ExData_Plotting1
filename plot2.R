
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

dt2$datetime<-strptime(paste(dt2$Date,dt2$Time),"%d/%m/%Y %H:%M:%S")
dt2$Global_active_power_N<-as.numeric(as.character(dt2$Global_active_power))

#plot
png(file="plot2.png",height=480,width=480,units="px");
with(dt2,plot(datetime,Global_active_power_N,ylab="Global Active Power (kilowatts)",xlab=' ',type='n'))
with(dt2,lines(datetime,Global_active_power_N))
dev.off()

# End of Program