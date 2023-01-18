test_specs <- function(targets,ctg_means){
# takes self$targets & self$ctg_means
vals<setNames(self$ctg_means$Values,self$ctg_means$attributes)
OUT<- NULL
OUT[1] <- vals['pH.LED.avg'] >= targets$LED_LOW &  vals['pH.LED.avg'] <=  targets$pH_LED_high
OUT[2] <- vals['pH.LED.CV'] < 30
OUT[3] <- vals['Gain.Avg'] >= (.9 * targets$gain) & vals['Gain.Avg'] <= (1.1 * targets$gain)
OUT[4] <- vals['Gain.CV'] < 5
OUT[5] <- vals['O2.LED.Avg'] >= targets$LED_LOW &  vals['O2.LED.Avg'] <=  targets$O2_LED_high
OUT[6] <- vals['O2.LED.CV'] < 30
OUT[7] <- vals['KSV.Avg'] >= (.9 * targets$ksv) & vals['KSV.Avg'] <= (1.1 * targets$ksv)
OUT[8] <- vals['KSV.CV'] < 5
c("FAIL","PASS")[factor(OUT)]

}
