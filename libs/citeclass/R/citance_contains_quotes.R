citance_contains_quotes <- function(text) {
  ifelse(grepl("[\"'“”]", text), yes=TRUE, no=FALSE)
}
