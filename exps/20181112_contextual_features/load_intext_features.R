# Loads features of in-text citations
library(tidyverse)
library(data.table)


# Set this working directory to the location of the script on your local computer
path_to_repo <- "~/Desktop/citation_classification/"
setwd(path_to_repo)


data = read_delim("https://www.dropbox.com/s/k0eqsbikxebtrmq/joi_sentences_2018_Nov_2018.txt?dl=1", delim = "\t", col_names = F)

# Assign mroe intuitive column names
names(data) <- c("doi", "title", "label", "text", "pub_year", "pub_month", "n_authors", "n_references", "n_sections", "n_sentences", "n_citation_sentence", "reference_seq",
                 "section_seq", "paragraph_seq", "sentence_seq", "citation_characer_seq", "n_citations_in_sentence", "sentence_character_seq")

# Process data, remove duplicates, replace in-text citation with easily recognizable tag
data <- data %>% 
  group_by(doi, sentence_seq) %>%
  summarize(
    text = gsub(paste("\\(*\\Q", unlist(label), "\\E[,;]*\\)*", sep="", collapse="|"), replacement="<CITATION>", text[1]),
    text = gsub("(<CITATION> )+<CITATION>", replacement="<CITATION>", text),
    text = tolower(text)
  ) %>%
  left_join(data, by = c("doi" = "doi", "sentence_seq" = "sentence_seq")) %>%
  select(-text.y) %>%
  rename(text = text.x)



# Define a function to check for a cue phrase
contains_cue <- function(text, cue_words) {
  return(ifelse(grepl(paste(" ", cue_words, " ", sep="", collapse = "|"), 
                      text, ignore.case=TRUE),
                yes=TRUE, no=FALSE)
  )
}

contains_numbers <- function(text) ifelse(grepl("\\d\\d+", text), yes=TRUE, no=FALSE)

contains_quotations <- function(text) ifelse(grepl("[\"'“”]", text), yes=TRUE, no=FALSE)

# Set path to access dictionary files
dictionary_files <- list.files("data/dictionaries/")

# Get dictionary-based features
features <- as.data.frame(rbind(sapply(dictionary_files, function(filename) {
  dictionary <- read.csv(paste0("data/dictionaries/", filename), stringsAsFactors = F, header = F)$V1
  return(contains_cue(data$text, as.character(dictionary)))
}))) %>%
  mutate(
    contain_number <- contains_numbers(data$text),
    contains_quotations <- contains_quotations(data$text)
  )
