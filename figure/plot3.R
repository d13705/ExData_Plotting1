library(readr)
library(dplyr)
library(lubridate)


data <- read_csv2("household_power_consumption.txt", na = c("?", "NA", ""))

data.1 <- data %>% mutate(Date = as.Date(Date, "%d/%m/%Y")) %>% 
        filter(year(Date) == 2007 & month(Date) == 2 & day(Date) %in% c(1, 2)) %>% 
        mutate(Global_active_power = as.numeric(Global_active_power),
               Global_reactive_power = as.numeric(Global_reactive_power),
               Global_intensity = as.numeric(Global_intensity),
               Sub_metering_1 = as.numeric(Sub_metering_1),
               Sub_metering_2 = as.numeric(Sub_metering_2),
               Sub_metering_3 = as.numeric(Sub_metering_3),
               dateTime = ymd(Date) + hms(Time)) %>% 
        select(- c(Date, Time))

png(filename = "plot3.png", width = 480, height = 480)

plot(data.1$dateTime, data.1$Sub_metering_1, type = "l", 
     ylab = "Energy sub metering", xlab = "")
lines(data.1$dateTime, data.1$Sub_metering_2, col = "red")
lines(data.1$dateTime, data.1$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1)

dev.off()
