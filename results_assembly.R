# This script assembles the results of searching the databases listed below

# Information is reported in this order:
# 1) Platform, 2) Database, 3) Years of access, 4) Institution accessed from, 5) Date search was conducted
# All of the searches in this script used the full Boolean search with lemmatization
# However, EBSCO was being difficult because of the search string length, so I made a few modifications:
# a) searches in EBSCO are ONLY in the abstract, and 2) there is no proximity operator for the time and outcomes
# which basically means EBSCO = AB(insect_terms AND outcome_terms AND time_terms)


# EBSCO::CAB Abstracts::1973-2019::UConn::Dec-13-2019
#CABABS <- litsearchr::import_results("./full_results/CAB Abstracts/")

# EBSCO::CAB Abstracts Archives::1910-1972::UConn::Dec-13-2019
CABAbsArch <- litsearchr::import_results("./full_results/CAB Abstracts Archives/")

#Error in detect_delimiter(zsub) : 
#  import failed: unknown reference delimiter
# comes from revtools

# EBSCO::GreenFILE::1898-2019::UConn::Dec-13-2019
#GreenFILE <- litsearchr::import_results("./full_results/GreenFILE/")

# EBSCO::OpenDissertations::1597-2019::UConn::Dec-13-2019
#OpenDiss <- litsearchr::import_results("./full_results/OpenDiss/")
#opendiss2 <- revtools::read_bibliography("./full_results/OpenDiss/0403955d-aa40-4e81-876b-5b0f81d1a2d6.ris")
#opendiss2$pages <- rep("", nrow(opendiss2))
#opendiss2$institution <- rep("", nrow(opendiss2))
#opendiss2$journal <- rep("", nrow(opendiss2))
#opendiss2$volume <- rep("", nrow(opendiss2))
#opendiss2$issues <- rep("", nrow(opendiss2))
#opendiss2$doi <- rep("", nrow(opendiss2))
#opendiss2$language <- rep("", nrow(opendiss2))s
#OpenDiss <- synthesisr::import_revtools(opendiss2)
#OpenDiss <- synthesisr::standardize_df(OpenDiss)
# EBSCO::Academic Search Premier::1887-2019::UConn::Dec-13-2019
#AcaSP <- litsearchr::import_results("./full_results/Academic Search Premier/")

# EBSCO::Agricola::1970-2019::UConn::Dec-13-2019
#Agric <- litsearchr::import_results("./full_results/Agricola/")

# Web of Science::BIOSIS Citation Index::1926-2019::UConn::Aug-14-2019
#biosis1 <- litsearchr::import_results("./full_results/biosis/pre-2000/")
#biosis2 <- litsearchr::import_results("./full_results/biosis/2000-2009/")
#biosis3 <- litsearchr::import_results("./full_results/biosis/2010-2014/")
#biosis4 <- litsearchr::import_results("./full_results/biosis/2015-2019/")
#biosis <- rbind(biosis1, biosis2, biosis3, biosis4)
#rm(biosis1, biosis2, biosis3, biosis4)

# Web of Science::Zoological Record::1864-2019::UConn::Aug-14-2019
#zoorec1 <- litsearchr::import_results("./full_results/zoorec/pre-2000/")
#zoorec2 <- litsearchr::import_results("./full_results/zoorec/2000-2009/")
#zoorec3 <- litsearchr::import_results("./full_results/zoorec/2010-2014/")
#zoorec4 <- litsearchr::import_results("./full_results/zoorec/2015-2019/")
#zoorec <- rbind(zoorec1, zoorec2, zoorec3, zoorec4)
#rm(zoorec1, zoorec2, zoorec3, zoorec4)

# Scopus::Scopus::1788-2019::UConn::Aug-14-2019
#scopus <- litsearchr::import_results(directory="./full_results/scopus/")

## okay, so for these, I have the years of access written down somewhere and just have to find piece of paper
# Web of Science::SciElo::oops-oops::UMN::Oct-04-2019
#scielo <- litsearchr::import_results("./full_results/WoS_Scielo/")

# Web of Science::Core Collection::oops-oops::UMN::Oct-04-2019
#core <- litsearchr::import_results("./full_results/WoS_core_collection/")

# Web of Science::CABI::oops-oops::UMN::Oct-04-2019
CABI1 <- litsearchr::import_results("./full_results/WoS_CABI/1910-1969/")
CABI2 <- litsearchr::import_results("./full_results/WoS_CABI/1970-1989/")
CABI3 <- litsearchr::import_results("./full_results/WoS_CABI/1990-1999/")
CABI4 <- litsearchr::import_results("./full_results/WoS_CABI/2000-2009/")
CABI5 <- litsearchr::import_results("./full_results/WoS_CABI/2010-2019/")
CABI <- rbind(CABI1, CABI2, CABI3, CABI4, CABI5)
rm(CABI1, CABI2, CABI3, CABI4, CABI5)

# Web of Science::Biological Abstracts::oops-oops::UMN::Oct-04-2019
#bioabs <- litsearchr::import_results("./full_results/WoS_BiologicalAbstracts/")

# Web of Science::Korean Citation Index::oops-oops::UMN::Oct-04-2019
kci <- litsearchr::import_results("./full_results/KCI/")

# Web of Science::Data Citation Index::oops-oops::UMN::Oct-04-2019
datacit <- litsearchr::import_results("./full_results/DataCitationIndex/")

# Web of Science::Russian Science Citation Index::oops-oops::UMN::Oct-04-2019
russ <- litsearchr::import_results(filename="./full_results/RussianScienceCI.txt")

# EBSCO::Wildlife and Ecology Studies Worldwide::1935-2019::UMN::Oct-04-2019
#wesw <- litsearchr::import_results(filename="./full_results/EBSCO_Wildlife_and_Ecology.ris")

#save.image("./results_loaded.RData")

#anything not commented out is not importing and needs some custom code or updates to litsearchr

loaded_results <- rbind(biosis, Agric, bioabs, CABABS, core, GreenFILE, OpenDiss, scielo, scopus, wesw, zoorec)
write.csv(loaded_results, "./most_searches_imported.csv")
loaded_results <- read.csv("E:/most_searches_imported.csv")

exact_title <- which(duplicated(loaded_results$title[-which(loaded_results$title=="" | is.na(loaded_results$title))]))
# removing 206,174 exact title duplicates
loaded_results <- loaded_results[-exact_title, ]

exact_doi <- which(duplicated(loaded_results$doi[-which(loaded_results$doi=="" | is.na(loaded_results$doi))]))
loaded_results <- loaded_results[-exact_doi, ]
# removed 50420 exact doi
write.csv(loaded_results, "./exact_title_doi_removed.csv")

loaded_results <- litsearchr::remove_duplicates(loaded_results[-which(loaded_results$title=="" | is.na(loaded_results$title)),], 
                                                field="title", method="quick")

# down to only 145,667 after that deduplication!
# moving these over to irrelevant_probably.R
