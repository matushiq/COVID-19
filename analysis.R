library(tidyverse)
library(lubridate)

input.deaths <- read_csv("csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Deaths.csv")
deaths <- pivot_longer(input.deaths, 5:length(colnames(input.deaths)), names_to = "date", values_to = "deaths")
#deaths$date < as_date(deaths$date, format = "%m/%d/%y", tz="")
deaths <- deaths %>%
  mutate(date = as_date(date, format = "%m/%d/%y", tz=""))

deaths.2 <- deaths %>%
  group_by(`Country/Region`, date) %>%
  mutate(deaths = sum(deaths))

p <- ggplot(data = deaths, aes(x = date, y = deaths, group = `Country/Region`, colour = `Country/Region`)) +
  geom_line() +
  theme(legend.position = "none") +
  geom_point()
p

p <- ggplot(data = deaths.2, aes(x = date, y = deaths, group = `Country/Region`, colour = `Country/Region`)) +
  geom_line() +
  theme(legend.position = "none") +
  geom_point()
p

#as_date("03/07/20", format = "%m/%d/%y", tz="")
a <- filter(deaths, `Country/Region` == "China")