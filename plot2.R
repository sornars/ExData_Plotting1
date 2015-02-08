# Download source data and clean up temp files
f <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", f, method = "curl")
data <- unz(f, "household_power_consumption.txt")
household_power_consumption <- read.csv(data, sep=";", na.strings="?")
unlink(f)
rm(data)
rm(f)

# Convert Date Time and columns to Dates and Times and select subset
household_power_consumption$Date <- as.Date.character(household_power_consumption$Date, "%d/%m/%Y")
household_power_consumption <- household_power_consumption[household_power_consumption$Date >= as.Date("2007-02-01") & household_power_consumption$Date <= as.Date("2007-02-02"),]
household_power_consumption$Time <- strptime(paste(household_power_consumption$Date, household_power_consumption$Time), format = "%Y-%m-%d %H:%M:%S")

# Create plot and save to PNG
png('plot2.png', width=480, height=480, bg = "transparent")
plot(household_power_consumption$Time, household_power_consumption$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()
