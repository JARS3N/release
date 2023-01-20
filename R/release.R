release <- R6::R6Class(
  "release",
  public = list(
    Lot = NULL,
    type = NULL,
    number = NULL,
    Inst = NULL,
    wetqc = NULL,
    targets = NULL,
    tbl = NULL,
    sn_means = NULL,
    means = NULL,
    sds = NULL,
    cvs = NULL,
    specs_here = NULL,
    ctg_means =  NULL,
    kable_markdown = NULL,
    RMD = function(){generate_rmd(self$Lot,self$Inst,self$type,self$kable_markdown)},
    wet_qc = NULL,
    initialize = function(LOT, INST) {
      require(dplyr)
      self$Lot <- LOT
      self$Inst <- INST
      self$type <- substr(self$Lot, 1, 1)
      self$number<- substr(self$Lot,2,6)
      self$tbl<-adminKraken::wetqc_tbl()[[self$type]]
      self$wetqc<-pull_wet_qc(self$tbl,self$Lot,self$Inst)
      self$targets <- get_targets(self$Lot)
      self$targets$LED_LOW <-setNames(c(1000,1000,1000),c("W","B","C"))[self$type]
      self$targets$pH_LED_high <-setNames(c(15000,15000,15000),c("W","B","C"))[self$type]
      self$targets$O2_LED_high <-setNames(c(15000,15000,3000),c("W","B","C"))[self$type]
      self$sn_means <-sn_means(self$wetqc)
      self$means <- summarise_all(self$sn_means,list(mean),na.rm=T)
      self$sds <- summarise_all(self$sn_means,list(sd),na.rm=T)
      self$cvs <- self$sds / self$means * 100
      self$ctg_means<-data.frame(attributes = gen_attr())
      self$ctg_means$Values <- c(
        round(self$means$pH.Led.avg,0),
        round(self$cvs$pH.Led.avg,2),
        round(self$means$Gain.avg,2),
        round(self$cvs$Gain.avg,2),
        round(self$means$O2.Led.avg,0),
        round(self$cvs$O2.Led.avg,2),
        round(self$means$KSV.avg,4),
        round(self$cvs$KSV.avg,2)
      )
      self$ctg_means$specifications<-gen_spec_str(self$targets$LED_LOW,
                                                       self$targets$pH_LED_high,
                                                       self$targets$O2_LED_high,
                                                       self$targets$gain,
                                                       self$targets$ksv,
                                                       self$targets$attr_len)
      self$ctg_means$Results<-test_specs(self$targets,self$ctg_means)
      #self$ctg_means$Results[is.na(self$ctg_means$Results)]<-"???"
      #self$ctg_means$Values[is.na(self$ctg_means$Values)]<-"missing"
      self$kable_markdown <- get_kable(self$ctg_means)
    }
  )
)
