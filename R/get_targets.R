get_targets <- function(lot) {
  my_db <- adminKraken::con_dplyr()
  suppressWarnings(
    tbl(my_db, "lotview") %>%
      select(., Type, Lot = `Lot Number`, ID = `Barcode Matrix ID`) %>%
      filter(Type == substr(lot, 1, 1) &
               Lot == substr(lot, 2, 6)) %>%
      select(ID) %>%
      left_join(., tbl(my_db, "barcodematrixview"), by =
                  "ID") %>%
      select(
        ID,
        o2em = O2_A,
        ksv = O2_B,
        phem = PH_A,
        slope = PH_B,
        intercept = PH_C
      ) %>%
      mutate(gain = (phem * slope) + intercept) %>%
      collect(., warnings = FALSE)
  )
}
