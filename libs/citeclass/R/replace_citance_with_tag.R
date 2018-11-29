replace_citance_with_tag <- function(text, citance_label, replacement = "<CITATION>") {
  new_text = gsub(paste("\\(*\\Q", citance_label, "\\E[,;]*\\)*", sep="", collapse="|"), replacement=replacement, text)
  new_text = gsub("(<CITATION> )+<CITATION>", replacement=replacement, new_text)
  return(new_text)
}
