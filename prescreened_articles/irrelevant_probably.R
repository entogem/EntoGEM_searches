# This script is to detect which articles probably do not meet inclusion criteria
# We filter them out by terms appearing in titles to group them for easier title screening

# Function to find the articles that match title terms
detect_terms <- function(df, terms){
  bad <- c()
  for(i in 1:length(terms)){
    detected <- which(stringr::str_detect(tolower(df$title), terms[i]))
    bad <- unique(append(bad, detected))
  }
  return(bad)
}

# First, we separate out articles that are most likely about managed populations
# We will check back in on them later to see if they have control plots

managed <- c("pesticid", "insecticid", "\\bbt\\b", "biocontrol", "biological control", "poison", "pest control", 
     "entomopathogenic nematodes", "anthranilic diamide",
     "bacillus thuringiensis", "fungicid", "larvicid", "meloidogyne incognita", 
     "nematicid", "resistant", "sublethal", "chlorfluazuron",
     "cypermethrin", "diflubenzuron", "entomophthoraceae", 
     "herbicid", "imidacloprid", "methoxyfenozide", "sensitivity", 
     "susceptib", "thiamethoxam", "bed bug", "control")

bad <- detect_terms(articles, managed)
probably_bad <- articles[bad,]
write.csv(probably_bad, "./managed_articles.csv")

# Toss those ones out so they aren't shunted to multiple .csv files for review
articles <- articles[-bad,]

# Next, we can set aside articles that matched to "invertebrate" but are the wrong invertebrates

wrong_invertebrates <- c("spider", "\\btick", "arachnid", "nematode", "crustacean", "shrimp", 
       "prawn", "daphnia", "amphipod", "\\bcrab\\b", "\\bmite\\b", "\\bmites\\b",
       "\\bcrabs\\b", "millipede", "centipede", "woodlouse", "woodlice", "sow bug", "pill bug", 
       "harvestmen", "opiliones", "fish lice", "fish louse", "carp lice", "carp louse", "salmon louse", "ixodes",
       "lyme", "borrelia", "burgdorferi")

bad <- detect_terms(articles, wrong_invertebrates)
probably_bad <- articles[bad,]
write.csv(probably_bad, "./wrong_invertebrates.csv")
articles <- articles[-bad,]

# In addition to the wrong type of invertebrates, we might have gotten articles that are just not even on insects

wrong_taxa <- c("fish", "trout", "salmon", "whale", "dolphin", "mammal", "bird", "lizard", 
    "turtle", "reptile", "salamander", "amphibian", "squamat")

bad <- detect_terms(articles, wrong_taxa)
probably_bad <- articles[bad,]
write.csv(probably_bad, "./wrong_taxa.csv")
articles <- articles[-bad,]

# Almost all our outcome measures are ecological, not evolutionary, so we want to separate out evolution
# Sure, some of these may also have population abundance type measures, but unlikely, so we will screen them separately
# A lot of them are measures of things like "changes in gene abundance in drosophila"

evolution <- c("multilocus", "dna", "\\brna\\b", "\\bsequenc", "polymorphism", "mitochondria", "selection", "genetic", 
               "gene\\b", "diversification", "evolution", "phylogen", "phylogeog", "genes\\b",
               "fitness", "radiation", "adaptation", "adaptive", "ancient lineage", "inbreeding", "molecular", "transposon", "retrotransposable", "transposable",
               "transcriptom", "founder effect", "dimorphism", "developmental", "allometr", "heritability", "inheritance", "evolved", "allel", "polyploid",
               "divergence")

molecular <-  c("protein", "splicing", "chromosom",  "receptor", "synthetic", "neuron", "\\brna", "dna", "catalytic", "enzym", "isotope", "binding",
                "intron", "exon\\b", "homologous", "recombination", "regulatory", "molecule", "molecular", "pathway", "\\bsequenc", "\\bcell\\b", "redox", "microb", "bacteria", "neuro", "transcription", "metabolism", "amino acid",
                "reductase", "sulfide", "ethyl", "genom", "phosphor", "\\bcells\\b", "\\bcellular\\b", "transmitter", "patients", "anaphyl", "allerg", "homolog",
                "cuticle"  )

paleo <- c("cretaceous", "jurassic", "triassic", "quaternary", "fossil", "paleo")

all_evol <- unique(append(append(evolution, molecular),paleo))

bad <- detect_terms(articles, all_evol)
probably_bad <- articles[bad,]
write.csv(probably_bad, "./evolution.csv")
articles <- articles[-bad,]

# Another group to ignore is things that are not in natural settings

lab <- c("laboratory", "lab reared", "lab rearing", "lab-reared", "lab-rearing")

bad <- detect_terms(articles, lab)
probably_bad <- articles[bad,]
write.csv(probably_bad, "./laboratory.csv")
articles <- articles[-bad,]

# And lastly, things that are probably about humans

people <- c("virus", "viral", "malaria", "vector", "disease", "epidemic", 
            "trypanosomiasis", "zika", "syndrome", "antibod", "immun", "infectious", "epidemiol", 
            "brain injury", "brain", "muscle", "muscular", "skeletal")

bad <- detect_terms(articles, people)
probably_bad <- articles[bad,]
write.csv(probably_bad, "./human_centered.csv")
articles <- articles[-bad,]


# Whatever is left over
write.csv(articles, "./still_need_screening.csv")
