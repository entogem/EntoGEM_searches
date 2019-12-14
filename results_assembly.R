# This script assembles the results of searching the databases listed below

# Information is reported in this order:
# 1) Platform, 2) Database, 3) Years of access, 4) Institution accessed from, 5) Date search was conducted
# All of the searches in this script used the full Boolean search with lemmatization
# However, EBSCO was being difficult because of the search string length, so I made a few modifications:
# a) searches in EBSCO are ONLY in the abstract, and 2) there is no proximity operator for the time and outcomes
# which basically means EBSCO = AB(insect_terms AND outcome_terms AND time_terms)

# EBSCO::CAB Abstracts::1973-2019::UConn::Dec-13-2019
CABABS <- litsearchr::import_results("./EntoGEM_searches/full_results/CAB Abstracts/")

# EBSCO::CAB Abstracts Archives::1910-1972::UConn::Dec-13-2019
CABAbsArch <- litsearchr::import_results("./EntoGEM_searches/full_results/CAB Abstracts Archives/")

# EBSCO::GreenFILE::1898-2019::UConn::Dec-13-2019
GreenFILE <- litsearchr::import_results("./EntoGEM_searches/full_results/GreenFILE/")

# EBSCO::OpenDissertations::1597-2019::UConn::Dec-13-2019
OpenDiss <- litsearchr::import_results("./EntoGEM_searches/full_results/OpenDiss/")

# EBSCO::Academic Search Premier::1887-2019::UConn::Dec-13-2019
AcaSP <- litsearchr::import_results("./EntoGEM_searches/full_results/Academic Search Premier/")

# EBSCO::Agricola::1970-2019::UConn::Dec-13-2019
Agric <- litsearchr::import_results("./EntoGEM_searches/full_results/Agricola/")

# Web of Science::BIOSIS Citation Index::1926-2019::UConn::Aug-14-2019
biosis <- litsearchr::import_results("./EntoGEM_searches/full_results/biosis/")

# Web of Science::Zoological Record::1864-2019::UConn::Aug-14-2019
zoorec <- litsearchr::import_results("./EntoGEM_searches/full_results/zoorec/")

# Scopus::Scopus::1788-2019::UConn::Aug-14-2019
scopus <- litsearchr::import_results("./EntoGEM_searches/full_results/scopus/")

## okay, so for these, I have the years of access written down somewhere and just have to find piece of paper
# Web of Science::SciElo::oops-oops::UMN::Oct-04-2019
scielo <- litsearchr::import_results("./EntoGEM_searches/full_results/WoS_Scielo/")

# Web of Science::Core Collection::oops-oops::UMN::Oct-04-2019
core <- litsearchr::import_results("./EntoGEM_searches/full_results/WoS_core_collection/")

# Web of Science::CABI::oops-oops::UMN::Oct-04-2019
CABI <- litsearchr::import_results("./EntoGEM_searches/full_results/WoS_CABI/")

# Web of Science::Biological Abstracts::oops-oops::UMN::Oct-04-2019
bioabs <- litsearchr::import_results("./EntoGEM_searches/full_results/WoS_BiologicalAbstracts/")

# Web of Science::Korean Citation Index::oops-oops::UMN::Oct-04-2019
kci <- litsearchr::import_results("./EntoGEM_searches/full_results/KCI/")

# Web of Science::Data Citation Index::oops-oops::UMN::Oct-04-2019
datacit <- litsearchr::import_results("./EntoGEM_searches/full_results/DataCitationIndex/")

# Web of Science::Russian Science Citation Index::oops-oops::UMN::Oct-04-2019
russ <- litsearchr::import_results(filename="./EntoGEM_searches/full_results/RussianScienceCI.txt")

# EBSCO::Wildlife and Ecology Studies Worldwide::1935-2019::UMN::Oct-04-2019
wesw <- litsearchr::import_results(filename="./EntoGEM_searches/full_results/EBSCO_Wildlife_and_Ecology.ris")


