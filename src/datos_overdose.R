### Gina Jiménez
### Public Health Watch 
### July 2024
#######################

rm(list=ls())

library(pacman)
p_load(tidyverse, zoo, data.table, janitor)

dir <-  "/Users/georginajimenez92/Documents/GitHub/overdoses_sa/"

data1 <- read.csv(paste0(dir, "input/MethDeaths.csv"), nrows = 6)%>%
         clean_names()%>%
         select(-c(notes, year, population, crude_rate))%>%
         rename(year=year_code)%>%
         mutate(drug_type="Methamphetamine")

data2 <- read.csv(paste0(dir, "input/Heroin&Fentanyl.csv"), nrows = 6)%>%
         clean_names()%>%
         select(-c(notes, year, population, crude_rate))%>%
         rename(year=year_code)%>%
         mutate(drug_type="Heroin, fentanyl and tramadol")

data3 <- read.csv(paste0(dir, "input/AllDrugDeaths.csv"), nrows = 6)%>%
         clean_names()%>%
         select(-c(notes, year, population, crude_rate))%>%
         rename(year=year_code)%>%
         mutate(drug_type="All deaths")

data <- bind_rows(data1, data2, data3)%>%
        pivot_wider(names_from=drug_type, values_from=deaths)

write.csv(data, paste0("/Users/georginajimenez92/Documents/GitHub/overdoses_sa/", 
                       "output/drug_deaths.csv"))
