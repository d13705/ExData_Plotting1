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


png(filename = "plot2.png", width = 480, height = 480)

plot(data.1$dateTime, data.1$Global_active_power, type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = "")

dev.off()
