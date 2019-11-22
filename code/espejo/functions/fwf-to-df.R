# LAST UPDATED
# 2019-11-20

fwf_to_df <- function(this_data, this_dict, return_time=FALSE) {
  if (return_time) {
    t0 <- Sys.time()
  }
  
  
  # READ AND FORMAT DICTIONARY FILE
  dict_df <- read.table(this_dict, skip=2, fill=TRUE, stringsAsFactors=FALSE, row.names=NULL)
  colnames(dict_df) <- c('col_num','col_type','col_name','col_width','col_lbl')
  dict_df <- dict_df[-nrow(dict_df),]
  
  dict_df$col_width <- as.integer(sapply(dict_df$col_width,
                                         gsub,
                                         pattern = '[^0-9\\.]',
                                         replacement = ''))
  
  dict_df$col_type <- sapply(dict_df$col_type, function(x) {
    ifelse(x %in% c('int','byte','long'),
           'i',
           ifelse(x == 'float', 
                  'n',
                  ifelse(x == 'double', 'd', 'c')))
  })
  
  dict_df$col_type <- ifelse(is.na(dict_df$col_type), 'c', dict_df$col_type)
  
  # READ IN DATA USING FIXED WIDTH FILE SPECS
  this_df <- read_fwf(file = this_data,
                      fwf_widths(widths = dict_df$col_width, col_names = dict_df$col_name),
                      col_types = paste(dict_df$col_type, collapse = ''))
  
  attributes(this_df)$variable_labels <- dict_df$col_lbl
  
  # GET TIMES IF NEEDED
  if (return_time) {
    t1 <- Sys.time()
    elapsed <- t1-t0
    
    return(list(df=this_df,
                elapsed=elapsed))
  } else {
    return(this_df)
  }
}
