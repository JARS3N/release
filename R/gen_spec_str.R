gen_spec_str <-
  function(ledlow,
           phledhigh,
           o2ledhigh,
           gain,
           ksv,
           attrlen) {
    c(
      paste0(">= ", ledlow, " & <=", phledhigh),
      "< 30",
      paste0(gain * c(1, .1), collapse = " +/- "),
      "< 5",
      paste0(">= ", ledlow, " & <=", o2ledhigh),
      "< 30",
      paste0(ksv * c(1, .1), collapse = " +/- ") ,
      "< 5"
    )
  }
