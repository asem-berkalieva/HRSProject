source('functions/fwf-to-df.R')

# ALL DATA FILES
path_to_files <- '../../../../Dropbox/cal/classes/longitudinal/longitudinal-project/download/'
data_files <- list.files(paste0(path_to_files,'h10da'),
                         full.names=TRUE,
                         pattern='_R.da')

# ALL CORRESPONDING DICTIONARIES
dict_files <- gsub('da', 'sta', data_files)
dict_files <- gsub('\\.sta',   '\\.dct',   dict_files)


# SEE THE KTH DATAFRAME
k <- 1

this_data <- data_files[k]
this_dict <- dict_files[k]


this_df <- fwf_to_df(this_data, this_dict)
this_df
