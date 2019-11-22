###########################
# 1. READ IN FILES FOR 2010
source('functions/fwf-to-df.R')

# ALL "MASTER" DATA FILES
path_to_files <- '../../../../Dropbox/cal/classes/longitudinal/longitudinal-project/download/'
data_files_master <- list.files(path_to_files, pattern='da')


data_files <- list.files(paste0(path_to_files, data_files_master[1]), # LOOKING AT FIRST FILE
                         full.names=TRUE,
                         pattern='_(R|H).da')

# NARROW IT DOWN
year_data <- data_files[grep(x=data_files, pattern='[0-9]{2}(B|C|Q|PR|J)')]
year_data <- year_data[-which(grepl('PR_H', year_data))]


year_dict <- gsub('da', 'sta', year_data)
year_dict <- gsub('\\.sta',   '\\.dct',   year_dict)



#################
# B: Demographics

b_data <- year_data[1]
b_dict <- year_dict[1]

# DATAFRAME FUNCTION AVAILABLE IN SUBDIRECTORY / SOURCED AT BEGINNING
b <- fwf_to_df(b_data, b_dict)

# SUBSET
b <- b %>% select(HHID, PN, MB014)


##############################
# C: Depression variable PC150
c_data <- year_data[2]
c_dict <- year_dict[2]

# DATAFRAME FUNCTION AVAILABLE IN SUBDIRECTORY / SOURCED AT BEGINNING
c <- fwf_to_df(c_data, c_dict)

# SUBSET
c <- c %>% select(HHID, PN, MC150, MC270M1, MC018)

table(c$MC150)

# 1: YES
# 5: NO

3283 / (17325 + 3283)


###############
# J: Employment
j_data <- year_data[3]
j_dict <- year_dict[3]

# DATAFRAME FUNCTION AVAILABLE IN SUBDIRECTORY / SOURCED AT BEGINNING
j <- fwf_to_df(j_data, j_dict)

# SUBSET
j <- j %>% select(HHID, PN, MJ005M1)


###########
# PR: Education
pr_data <- year_data[4]
pr_dict <- year_dict[4]

# DATAFRAME FUNCTION AVAILABLE IN SUBDIRECTORY / SOURCED AT BEGINNING
pr <- fwf_to_df(pr_data, pr_dict)

# SUBSET
pr <- pr %>% select(HHID, PN, MZ216)




###########
# Q: Income
q_data <- year_data[5]
q_dict <- year_dict[5]

# DATAFRAME FUNCTION AVAILABLE IN SUBDIRECTORY / SOURCED AT BEGINNING
q <- fwf_to_df(q_data, q_dict)

# SUBSET
q <- q %>% select(HHID, MQ015, MQ020, MQ025, MQ030, MQ035, MQ066, MQ107, MQ115, MQ121)



# MERGE THINGS
test <- merge(b, c, by=c('HHID', 'PN'))
head(test)

test <- merge(test, pr, by=c('HHID', 'PN'))
head(test)

test <- merge(test, j, by=c('HHID', 'PN'))
head(test)

test <- merge(test, q, by=c('HHID'))
head(test)

# CHECK COMPLETES
nrow(test)
x <- test[complete.cases(test),]

# write.csv(test, '../../data/merged/hrs-2010.csv')



###########################
# 2. READ IN FILES FOR 2012

data_files <- list.files(paste0(path_to_files, data_files_master[2]), # LOOKING AT FIRST FILE
                         full.names=TRUE,
                         pattern='_(R|H).da')

# NARROW IT DOWN
year_data <- data_files[grep(x=data_files, pattern='[0-9]{2}(B|C|Q|PR|J)')]
year_data <- year_data[-which(grepl('PR_H', year_data))]


year_dict <- gsub('da', 'sta', year_data)
year_dict <- gsub('\\.sta',   '\\.dct',   year_dict)



#################
# B: Demographics

b_data <- year_data[1]
b_dict <- year_dict[1]

# DATAFRAME FUNCTION AVAILABLE IN SUBDIRECTORY / SOURCED AT BEGINNING
b <- fwf_to_df(b_data, b_dict)

# SUBSET
b <- b %>% select(HHID, PN, NB014)


##############################
# C: Depression variable PC150
c_data <- year_data[2]
c_dict <- year_dict[2]

# DATAFRAME FUNCTION AVAILABLE IN SUBDIRECTORY / SOURCED AT BEGINNING
c <- fwf_to_df(c_data, c_dict)

# SUBSET
c <- c %>% select(HHID, PN, NC150, NC270M1, NC018)

round(table(c$NC150) / nrow(c), 2)

# 1: YES
# 5: NO


###############
# J: Employment
j_data <- year_data[3]
j_dict <- year_dict[3]

# DATAFRAME FUNCTION AVAILABLE IN SUBDIRECTORY / SOURCED AT BEGINNING
j <- fwf_to_df(j_data, j_dict)

# SUBSET
j <- j %>% select(HHID, PN, NJ005M1)

###########
# PR: Education
pr_data <- year_data[4]
pr_dict <- year_dict[4]

# DATAFRAME FUNCTION AVAILABLE IN SUBDIRECTORY / SOURCED AT BEGINNING
pr <- fwf_to_df(pr_data, pr_dict)

# SUBSET
pr <- pr %>% select(HHID, PN, NZ216)




###########
# Q: Income
q_data <- year_data[5]
q_dict <- year_dict[5]

# DATAFRAME FUNCTION AVAILABLE IN SUBDIRECTORY / SOURCED AT BEGINNING
q <- fwf_to_df(q_data, q_dict)

# SUBSET
q <- q %>% select(HHID, NQ015, NQ020, NQ025, NQ030, NQ035, NQ066, NQ107, NQ115, NQ121)



# MERGE THINGS
test <- merge(b, c, by=c('HHID', 'PN'))
head(test)

test <- merge(test, pr, by=c('HHID', 'PN'))
head(test)

test <- merge(test, j, by=c('HHID', 'PN'))
head(test)


test <- merge(test, q, by=c('HHID'))
head(test)

# CHECK COMPLETES
nrow(test)
x <- test[complete.cases(test),]

# write.csv(test, '../../data/merged/hrs-2012.csv')






###########################
# 3. READ IN FILES FOR 2014

data_files <- list.files(paste0(path_to_files, data_files_master[3]), # LOOKING AT FIRST FILE
                         full.names=TRUE,
                         pattern='_(R|H).da')

# NARROW IT DOWN
year_data <- data_files[grep(x=data_files, pattern='[0-9]{2}(B|C|Q|PR|J)')]
year_data <- year_data[-which(grepl('PR_H', year_data))]


year_dict <- gsub('da', 'sta', year_data)
year_dict <- gsub('\\.sta',   '\\.dct',   year_dict)



#################
# B: Demographics

b_data <- year_data[1]
b_dict <- year_dict[1]

# DATAFRAME FUNCTION AVAILABLE IN SUBDIRECTORY / SOURCED AT BEGINNING
b <- fwf_to_df(b_data, b_dict)

# SUBSET
b <- b %>% select(HHID, PN, OB014)


##############################
# C: Depression variable PC150
c_data <- year_data[2]
c_dict <- year_dict[2]

# DATAFRAME FUNCTION AVAILABLE IN SUBDIRECTORY / SOURCED AT BEGINNING
c <- fwf_to_df(c_data, c_dict)

# SUBSET
c <- c %>% select(HHID, PN, OC150, OC270M1, OC018)

round(table(c$OC150) / nrow(c), 2)

# 1: YES
# 5: NO


###########
# PR: Education
pr_data <- year_data[4]
pr_dict <- year_dict[4]

# DATAFRAME FUNCTION AVAILABLE IN SUBDIRECTORY / SOURCED AT BEGINNING
pr <- fwf_to_df(pr_data, pr_dict)

# SUBSET
pr <- pr %>% select(HHID, PN, OZ216)


###############
# J: Employment
j_data <- year_data[3]
j_dict <- year_dict[3]

# DATAFRAME FUNCTION AVAILABLE IN SUBDIRECTORY / SOURCED AT BEGINNING
j <- fwf_to_df(j_data, j_dict)

# SUBSET
j <- j %>% select(HHID, PN, OJ005M1)


###########
# Q: Income
q_data <- year_data[5]
q_dict <- year_dict[5]

# DATAFRAME FUNCTION AVAILABLE IN SUBDIRECTORY / SOURCED AT BEGINNING
q <- fwf_to_df(q_data, q_dict)

# SUBSET
q <- q %>% select(HHID, OQ015, OQ020, OQ025, OQ030, OQ035, OQ066, OQ107, OQ115, OQ121)



# MERGE THINGS
test <- merge(b, c, by=c('HHID', 'PN'))
head(test)

test <- merge(test, pr, by=c('HHID', 'PN'))
head(test)

test <- merge(test, j, by=c('HHID', 'PN'))
head(test)

test <- merge(test, q, by=c('HHID'))
head(test)

# CHECK COMPLETES
nrow(test)
x <- test[complete.cases(test),]

# write.csv(test, '../../data/merged/hrs-2014.csv')



###########################
# 4. READ IN FILES FOR 2016

data_files <- list.files(paste0(path_to_files, data_files_master[4]), # LOOKING AT FIRST FILE
                         full.names=TRUE,
                         pattern='_(R|H).da')

# NARROW IT DOWN
year_data <- data_files[grep(x=data_files, pattern='[0-9]{2}(B|C|Q|PR|J)')]
year_data <- year_data[-which(grepl('PR_H', year_data))]
year_data <- year_data[-which(grepl('J3', year_data))]



year_dict <- gsub('da', 'sta', year_data)
year_dict <- gsub('\\.sta',   '\\.dct',   year_dict)



#################
# B: Demographics

b_data <- year_data[1]
b_dict <- year_dict[1]

# DATAFRAME FUNCTION AVAILABLE IN SUBDIRECTORY / SOURCED AT BEGINNING
b <- fwf_to_df(b_data, b_dict)

# SUBSET
b <- b %>% select(HHID, PN, PB014)


##############################
# C: Depression variable PC150
c_data <- year_data[2]
c_dict <- year_dict[2]

# DATAFRAME FUNCTION AVAILABLE IN SUBDIRECTORY / SOURCED AT BEGINNING
c <- fwf_to_df(c_data, c_dict)

# SUBSET
c <- c %>% select(HHID, PN, PC150, PC270M1, PC018)

round(table(c$PC150) / nrow(c), 2)

# 1: YES
# 5: NO


###############
# J: Employment
j_data <- year_data[3]
j_dict <- year_dict[3]

# DATAFRAME FUNCTION AVAILABLE IN SUBDIRECTORY / SOURCED AT BEGINNING
j <- fwf_to_df(j_data, j_dict)

# SUBSET
j <- j %>% select(HHID, PN, PJ005M1)

###########
# PR: Education
pr_data <- year_data[4]
pr_dict <- year_dict[4]

# DATAFRAME FUNCTION AVAILABLE IN SUBDIRECTORY / SOURCED AT BEGINNING
pr <- fwf_to_df(pr_data, pr_dict)

# SUBSET
pr <- pr %>% select(HHID, PN, PZ216)




###########
# Q: Income
q_data <- year_data[5]
q_dict <- year_dict[5]

# DATAFRAME FUNCTION AVAILABLE IN SUBDIRECTORY / SOURCED AT BEGINNING
q <- fwf_to_df(q_data, q_dict)

# SUBSET
q <- q %>% select(HHID, PQ015, PQ020, PQ025, PQ030, PQ035, PQ066, PQ107, PQ115, PQ121)



# MERGE THINGS
test <- merge(b, c, by=c('HHID', 'PN'))
head(test)

test <- merge(test, pr, by=c('HHID', 'PN'))
head(test)

test <- merge(test, j, by=c('HHID', 'PN'))
head(test)

test <- merge(test, q, by=c('HHID'))
head(test)



# # MERGE THINGS
# test <- merge(b, c)
# head(test)
# 
# test <- merge(test, pr)
# head(test)
# 
# test <- merge(test, j)
# head(test)
# 
# test <- merge(test, q)
# head(test)

# CHECK COMPLETES
# nrow(test)
# x <- test[complete.cases(test),]

# write.csv(test, '../../data/merged/hrs-2016.csv')

