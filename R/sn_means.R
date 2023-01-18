sn_means <- function(wetqc) {
  group_by(wetqc, sn) %>%
    summarise(
      pH.Led.avg = mean(pH.LED),
      Gain.avg = mean(Gain, na.rm = T),
      O2.Led.avg = mean(O2.LED),
      KSV.avg = mean(KSV, na.rm = T)
    ) %>% select(-sn)
}
