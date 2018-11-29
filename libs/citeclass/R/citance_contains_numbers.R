citance_contains_numbers <- function(text) {
  ifelse(grepl("\\d\\d+", text), yes=TRUE, no=FALSE)
}
