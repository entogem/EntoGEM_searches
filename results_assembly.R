# This script assembles the results of searching the databases listed below

# Information is reported in this order:
# 1) Platform, 2) Database, 3) Years of access, 4) Institution accessed from, 5) Date search was conducted
# All of the searches in this script used the full Boolean search with lemmatization
# However, EBSCO was being difficult because of the search string length, so I made a few modifications:
# a) searches in EBSCO are ONLY in the abstract, and 2) there is no proximity operator for the time and outcomes
# which basically means EBSCO = AB(insect_terms AND outcome_terms AND time_terms)

# EBSCO::CAB Abstracts::1973-2019::UConn::Dec-13-2019

CABABS <- litsearchr::import_results("./full_results/Dec13_2019/CAB Abstracts/")

# EBSCO::CAB Abstracts Archives::1910-1972::UConn::Dec-13-2019
# EBSCO::GreenFILE::1898-2019::UConn::Dec-13-2019
# EBSCO::OpenDissertations::1597-2019::UConn::Dec-13-2019
# EBSCO::Academic Search Premier::1887-2019::UConn::Dec-13-2019
# EBSCO::Agricola::1970-2019::UConn::Dec-13-2019



# Web of Science::BIOSIS Citation Index::1926-2019::UConn::Aug-14-2019
# Web of Science::Zoological Record::1864-2019::UConn::Aug-14-2019

# Scopus::Scopus::1788-2019::UConn::Aug-14-2019

## okay, so for these, I have the years of access written down somewhere and just have to find piece of paper
# Web of Science::SciElo::oops-oops::UMN::Oct-04-2019
# Web of Science::Core Collection::oops-oops::UMN::Oct-04-2019
# Web of Science::CABI::oops-oops::UMN::Oct-04-2019
# Web of Science::Biological Abstracts::oops-oops::UMN::Oct-04-2019
# Web of Science::Korean Citation Index::oops-oops::UMN::Oct-04-2019
# Web of Science::Data Citation Index::oops-oops::UMN::Oct-04-2019
# Web of Science::Russian Science Citation Index::oops-oops::UMN::Oct-04-2019

# EBSCO::Wildlife and Ecology Studies Worldwide::1935-2019::UMN::Oct-04-2019



