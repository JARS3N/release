get_kable <- function(ctg_means) {
  knitr::kable(
    ctg_means,
    format = "markdown",
    padding = 0,
    row.names = F,
    escape = FALSE,
    longtable = T,
    options = list(rows.print = 11),
    align =c('l','l','c','c','c')
  )
}
