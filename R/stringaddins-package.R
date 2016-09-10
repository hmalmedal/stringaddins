#' Manipulate Strings
#'
#' RStudio add-ins for manipulating strings.
#'
#' Open a file in RStudio. Select text and execute one of the add-ins.
"_PACKAGE"

change_region <- function(f) {
  context <- tryCatch(rstudioapi::getActiveDocumentContext(),
                      error = function(e) NULL)
  if (!is.null(context)) {
    lapply(context$selection, function(sel) {
      Encoding(sel$text) <- "UTF-8"
      rstudioapi::modifyRange(sel$range, f(sel$text))
    })
  }
  invisible()
}

capitalize_region <- function() {
  change_region(stringi::stri_trans_totitle)
}

downcase_region <- function() {
  change_region(stringi::stri_trans_tolower)
}

upcase_region <- function() {
  change_region(stringi::stri_trans_toupper)
}

escape_region <- function() {
  change_region(stringi::stri_escape_unicode)
}

unescape_region <- function() {
  change_region(stringi::stri_unescape_unicode)
}
