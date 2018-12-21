load_joi_data <- function(path = NULL) {
  if (is.null(path)) {
    path = "https://www.dropbox.com/s/k0eqsbikxebtrmq/joi_sentences_2018_Nov_2018.txt?dl=1"
  }
  data = read_delim(path, delim = "\t", col_names = F)

  # Assign mroe intuitive column names
  names(data) <- c("doi", "title", "label", "text", "pub_year", "pub_month", "n_authors", "n_references", "n_sections", "n_sentences", "n_citation_sentence", "reference_seq",
                   "section_seq", "paragraph_seq", "sentence_seq", "citation_characer_seq", "n_citations_in_sentence", "sentence_character_seq")

  return(data)
}
