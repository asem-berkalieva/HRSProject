library(readr)

####################
# CLEAN COLUMN NAMES

h2010 <- read_csv('../../data/merged/hrs-2010.csv')
h2012 <- read_csv('../../data/merged/hrs-2012.csv')
h2014 <- read_csv('../../data/merged/hrs-2014.csv')
h2016 <- read_csv('../../data/merged/hrs-2016.csv')

names(h2010)[4:ncol(h2010)] <- gsub('M', '', names(h2010)[4:ncol(h2010)])
names(h2012)[4:ncol(h2012)] <- gsub('N', '', names(h2012)[4:ncol(h2012)])
names(h2014)[4:ncol(h2014)] <- gsub('O', '', names(h2014)[4:ncol(h2014)])
names(h2016)[4:ncol(h2016)] <- gsub('P', '', names(h2016)[4:ncol(h2016)])

sapply(list(h2010, h2012, h2014, h2016), names)



#############################
# CONNECT HOUSEHOLDS TOGETHER?

nrow(h2010) + nrow(h2012) + nrow(h2014) + nrow(h2016)

full_data <- rbind(h2010, h2012, h2014, h2016)


full_data[,which(grepl('Q', names(full_data)))] <- apply(full_data[,which(grepl('Q', names(full_data)))], 2, function(x) ifelse(is.na(x), 0, x))


clean <- full_data %>% 
  mutate(income = Q015 + Q020 + Q025 + Q030 + Q035 + Q066 + Q107 + Q115 + Q121) %>%
  select (HHID, PN, B014, C150, C2701, C018, Z216, income) %>%
  mutate(income = ifelse(income==0, NA, income)) %>%
  rename(education=B014) %>%
  rename(depression=C150) %>%
  rename(heart=C2701) %>%
  rename(cancer=C018) %>%
  rename(years_education=Z216) %>%
  rename(hhid=HHID) %>%
  rename(pn=PN)

years <- c(rep(2010, nrow(h2010)),
           rep(2012, nrow(h2012)),
           rep(2014, nrow(h2014)),
           rep(2016, nrow(h2016)))

clean <- cbind(clean, years)

clean <- clean %>%
  filter(depression %in% c(1,5)) %>%
  mutate(depression = ifelse(depression==1, 1, 0)) %>%
  mutate(person_id = paste0('h', hhid, 'pn', pn))


# write.csv(clean, '../../data/hrs.csv')
