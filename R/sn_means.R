sn_means <- function(wetqc) {
  group_by(wetqc, sn) %>%
    summarise(
      pH.Led.avg = mean(pH.LED,na.rm=T),
      Gain.avg = mean(Gain, na.rm = T),
      O2.Led.avg = mean(O2.LED,na.rm=T),
      KSV.avg = mean(KSV, na.rm = T)
    ) %>% select(-sn) %>%
  lapply(.,nan2na) %>%
  data.frame()
}
