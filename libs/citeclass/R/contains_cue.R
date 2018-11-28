# Checks a text (usually a sentence) for a given cue phrases
contains_cue <- function(text, cue_words) {
  return(ifelse(grepl(paste(" ", cue_words, " ", sep="", collapse = "|"),
                      text, ignore.case=TRUE),
                yes=TRUE, no=FALSE)
  )
}
