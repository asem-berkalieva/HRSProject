library(readr)


############
# PREVALENCE

h2010 <- read_csv('../../data/merged/hrs-2010.csv')
h2012 <- read_csv('../../data/merged/hrs-2012.csv')
h2014 <- read_csv('../../data/merged/hrs-2014.csv')
h2016 <- read_csv('../../data/merged/hrs-2016.csv')


prevalence <- do.call(rbind,
                      lapply(
                        list(h2010$MC150, h2012$NC150, h2014$OC150, h2016$PC150),
                        table
                      ))

prevalence <- prevalence[,c(1,3)]

c(depressed=sum(prevalence[,1]) / sum(prevalence),
  not=sum(prevalence[,2]) / sum(prevalence))
