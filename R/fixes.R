cv<-function(u){
  100*(sd(u,na.rm=T)/mean(u,na.rm=T))
}


sn_cvs <- function(wetqc) {
  wetqc %>%
    group_by(sn) %>%
    summarise(
      across(c(pH.LED, Gain, O2.LED, KSV), cv),
      .groups = "drop"
    ) %>%
    mutate(across(everything(), nan2na)) %>%
    select(-sn)
}
