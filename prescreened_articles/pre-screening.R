# First we prioritize articles that are most likely to meet criteria to reduce screening burden
# So we restrict to only those that have our best time and outcome terms in the title and abstract
# GAM and EMG came up with these terms, which is what we used for the first upload to SysRev
# The first upload only comes from BCI because we avoided massive deduplication first
# And that way, when we deduplicate the full set of results, we just load all_results in first to avoid repeats

naive_time <- c(
  "time series",
  "over time",
  "long-term",
  "long term",
  "interannual",
  "multi-year",
  "long-running ",
  "population trend"
)

extra_time <-
  c(
    "decline",
    "monitor",
    "years earlier",
    "years previous",
    "years prior",
    "historical baseline data",
    "baseline data",
    "historical collection",
    "historical comparison",
    "historical data",
    "year survey",
    "historical population",
    "historical presence",
    "years apart"
  )

naive_outcomes <- c(
  "species distribution",
  "geographic distribution",
  "species range",
  "population dynamics",
  "abundance",
  "occurrence",
  "occupancy",
  "diversity",
  "biodiversity",
  "species richness",
  "species presence",
  "biomass",
  "survey",
  "population trend",
  "assemblage"
)

timeterms <- unique(append(naive_time, extra_time))



all_results$time <- rep("", nrow(all_results))
all_results$outcome <- rep("", nrow(all_results))
all_results$text <- paste(all_results$title, all_results$abstract)

# I'm sure there is a more efficient way to code this
for(i in 1:length(timeterms)){
  x <- which(stringr::str_detect(all_results$text, timeterms[i]))
  all_results$time[x] <- timeterms[i]
}


for(i in 1:length(naive_outcomes)){
  x <- which(stringr::str_detect(all_results$text, naive_outcomes[i]))
  all_results$outcome[x] <-  naive_outcomes[i]
}

all_results$insect <- stringr::str_detect(all_results$text, "insect")

# needs to have all three to be prescreened
nope <- which(all_results$time=="" | all_results$outcome=="" | all_results$insect=="")

candidates <- all_results[-nope,]

# Eliza will deal with these at some point with topic modeling or better screening terms
save_for_later <- all_results[nope,]
write.csv(save_for_later, "./not_prescreened.csv")

# convert litsearchr stored data to a .ris for uploading to SysRev
write_bib <- function(df){
  biblio <- c()
  for(i in 1:nrow(df)){
    x <- df[i,]
    entry <- paste("TY - ", x$type, "AU - ", x$authors, "PY - ", x$year, "TI - ", x$title, 
                   "T2 - ", x$source, "SP - ", x$startpage, "EP - ", x$endpage, "VL - ", x$volume, "IS - ", x$issue, 
                   "AB - ", x$abstract, "KW - ", x$keywords, "DO - ", x$doi, "DB - ", x$database, sep="\n")
    biblio <- paste(biblio, entry, sep="\n")
    return(biblio)
  }
}

biblio <- write_bib(candidates)
writeLines(biblio, "./EntoGEM_prescreened_Dec13.ris")

