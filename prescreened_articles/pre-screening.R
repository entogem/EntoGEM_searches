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


all_results <- articles # from irrelevant_probably

find_terms <- function(df, terms){
  good <- c()
  for(i in 1:length(terms)){
    detected <- which(stringr::str_detect(tolower(df$text), terms[i]))
    good <- unique(append(good, detected))
  }
  return(good)
}

times <- find_terms(all_results, timeterms)
outcomes <- find_terms(all_results, naive_outcomes)
insects <- find_terms(all_results, "insect")

these <- which(times%in%outcomes)
yep <- which(these%in%insects)

candidates <- all_results[yep,]

# Eliza will deal with these at some point with topic modeling or better screening terms
# still have 94594 articles to deal with later
save_for_later <- all_results[-yep,]
write.csv(save_for_later, "./not_prescreened.csv")

# oops forgot that biosis was already pre-screened
sysrev <- litsearchr::import_results(filename="../../Downloads/prescreened_checkDec15.csv")

sysrevritles <- unique(tolower(tm::removePunctuation(sysrev$title)))
candidatetitles <- tolower(tm::removePunctuation(candidates$title))
overlap <- which(candidatetitles %in% sysrevritles)
candidates <- candidates[-overlap,]


# convert litsearchr stored data to a .ris for uploading to SysRev
write_bib <- function(df){
  biblio <- c()
  for(i in 1:nrow(df)){
    x <- df[i,]
    entry <- paste("TY - ", x$type, "AU - ", x$authors, "PY - ", x$year, "TI - ", x$title, 
                   "T2 - ", x$source, "SP - ", x$startpage, "EP - ", x$endpage, "VL - ", x$volume, "IS - ", x$issue, 
                   "AB - ", x$abstract, "KW - ", x$keywords, "DO - ", x$doi, "DB - ", x$database, sep="\n")
    biblio <- paste(biblio, entry, sep="\n")
  }
  return(biblio)
}

biblio <- write_bib(candidates)
writeLines(biblio, "./EntoGEM_prescreened_Dec15.ris")


