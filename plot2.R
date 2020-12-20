# Exploratory Data Analysis - Course Project 1 
# R version 4.0.2 (2020-06-22) -- "Taking Off Again"
# Windows 8
# Plot 2 - Measured global active power over time on 2007-Feb-01 and 2007-Feb-02

# Download the data
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url = fileUrl, destfile = "./data/data.zip")
dateDownloaded <- date()

# Unzip the compressed .zip file
unzip(zipfile = "./data/data.zip", exdir = "./data")

# Read the data into R
hpc_data1 <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?",
                        colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
						)

# Convert 'Date' column from character to date
hpc_data1$Date <- as.Date(strptime(hpc_data1$Date,"%e/%m/%Y"))

# Filter data of 2007-02-01 and 2007-02-02
hpc_data2 <- subset(hpc_data1, (as.Date("2007-02-01")<=Date & Date<=as.Date("2007-02-02")))

# Convert 'Date' and 'Time' columns to POSIXlt
hpc_data2$datetime <- strptime(paste(as.character(hpc_data2$Date), hpc_data2$Time),"%Y-%m-%d %H:%M:%S")

# Open graphic device
png(filename = "plot2.png", width = 480, height = 480, units = "px")

# Global active power over time on 2007-Feb-01 and 2007-Feb-02
plot(hpc_data2$datetime, hpc_data2$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

# Close graphic device
dev.off()