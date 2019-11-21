##################
# 1. READ IN FILES
source('functions/fwf-to-df.R')

# ALL "MASTER" DATA FILES
path_to_files <- '../../../../Dropbox/cal/classes/longitudinal/longitudinal-project/download/'
data_files_master <- list.files(path_to_files, pattern='da')


data_files <- list.files(paste0(path_to_files, data_files_master[1]), # LOOKING AT FIRST FILE
                         full.names=TRUE,
                         pattern='_R.da')

# ALL CORRESPONDING DICTIONARIES
dict_files <- gsub('da', 'sta', data_files)
dict_files <- gsub('\\.sta',   '\\.dct',   dict_files)


# SEE THE KTH DATAFRAME
k <- 1
this_data <- data_files[k]
this_dict <- dict_files[k]

# DATAFRAME FUNCTION AVAILABLE IN SUBDIRECTORY / SOURCED AT BEGINNING
this_df <- fwf_to_df(this_data, this_dict)
this_df



################################
# 2. GET SAMPLE OF UNIQUE HHID'S

time_elapsed <- unique_hhid <- vector(length=length(data_files))
households_keep <- vector(mode='list', length=length(data_files))
for (k in 1:length(data_files)) {
  t0 <- Sys.time()
  
  # SEE THE KTH DATAFRAME
  this_data <- data_files[k]
  this_dict <- dict_files[k]
  
  # DATAFRAME FUNCTION AVAILABLE IN SUBDIRECTORY / SOURCED AT BEGINNING
  this_df <- fwf_to_df(this_data, this_dict)
  
  # HOW MANY UNIQUE
  unique_hhid[k] <- length(unique(this_df$HHID))
  
  # SAMPLE SOME OF THE HOUSEHOLDS
  households_keep[[k]] <- sample(this_df$HHID, size=40, replace=FALSE)
  
  t1 <- Sys.time()
  time_elapsed[k] <- t1-t0
}

sum(time_elapsed) # DOESN'T TAKE A LOT OF TIME
unique_hhid # 14890 HOUSEHOLDS PER DATASET

households_keep <- unique(unlist(households_keep))


##############################################
# 3. GO THROUGH ALL DATASETS TO GET DATAFRAMES

# RECALL WE HAVE ALL THE MASTER DATA FILES HERE
data_files_master

data_files <- unlist(lapply(1:length(data_files_master),
                            function(k) {
                              list.files(paste0(path_to_files, data_files_master[k]),
                                         full.names=TRUE,
                                         pattern='_R.da')}))

# SERIOUSLY ALL CORRESPONDING DICTIONARIES
dict_files <- gsub('da', 'sta', data_files)
dict_files <- gsub('\\.sta',   '\\.dct',   dict_files)


# LOOP OVER ALL FILES TO RETRIEVE:
#   (1) MASTER FILE
#   (2) SUB DATA FILE
#   (3) YEAR
#   (4) DATAFRAME
#   (5) NUMBER OF ROWS KEPT

t0 <- Sys.time()

file_info <- vector(mode='list', length=length(data_files))
for (k in 1:length(data_files)) {
  # SEE THE KTH DATAFRAME
  this_data <- data_files[k]
  this_dict <- dict_files[k]
  
  # MASTER FILE
  splits <- strsplit(this_data, split='/')[[1]]
  master <- splits[length(splits)-1]
  sub    <- splits[length(splits)]
  year   <- gsub('[^0-9]', '', master)
  
  # DATAFRAME FUNCTION AVAILABLE IN SUBDIRECTORY / SOURCED AT BEGINNING
  this_df <- fwf_to_df(this_data, this_dict)
  this_df <- cbind(this_df, year=rep(year, nrow(this_df)))
  
  # GET DATAFRAME
  df <- this_df %>% filter(HHID %in% households_keep)
  
  # RETURN
  file_info[[k]] <- list(master=master,
                         sub=sub,
                         df=df,
                         n=nrow(df))
}

t1 <- Sys.time()
elapsed <- t1-t0


# SUMMARY TABLE
summary_df <- data.frame(do.call(rbind, lapply(file_info, `[`, c(1,2,4))))
summary_df <- apply(summary_df, 2, as.character)
write.csv(summary_df, '../../output-tables/summary-df.csv', row.names=FALSE)

# ALL COL NAMES
all_col_names <- lapply(1:length(file_info), function(k) {
  names(file_info[[k]]$df)
})

# IT DOES NOT SEEM LIKE THERE ARE A BUNCH OF Q'S THAT ARE NAMED THE SAME
# NEED TO DO MORE RESEARCH
intersections <- Reduce(function(x, y) intersect(x,y), all_col_names)

# CHECK WHERE 'OBSUHH' IS JUST OUT OF CURIOUSITY
# IT IS IN HALF OF THEM
sapply(1:length(all_col_names), function(k) 'OSUBHH' %in% all_col_names[[k]])



##########################
# 4. WRITE ALL DF'S TO CSV
lapply(1:length(file_info), function(x) write.csv(file_info[[x]]$df,
                                                  paste0('../../data/', gsub('da', 'csv', summary_df[x,2]))))
