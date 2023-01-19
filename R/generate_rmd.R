generate_rmd<- function(Lot,Inst,type,kbl){
    dash<-"---  "
    blank<-"  "
    end_tick<-"```  "
    stars<-"****  "
    codeblock<-"```{}  "
    sig_section<- c(stars,codeblock,rep(blank,3),end_tick,blank)
    fl<-c(
      dash,
      "title: \"%PLAT% Wet QC Lot Release\"  " ,
      "output: html_document  " ,
      dash,
      "### LOT: %Lot%  ",
      "### QC instrument: %inst%  ",
      kbl,
      rep(blank,3),
      "### Approved for Release by:  " ,
      sig_section,
      "### Deviation Approved by:  ",
      sig_section
    )
    plat<- c("W"="XFe96","B"="XFe24","C"="XFp")[type]
    vars<- c("%Lot%","%inst%","%PLAT%")
    vals<- c(Lot,Inst,plat)
    for (i in 1:3) {fl<-gsub(vars[i],vals[i],fl)}

paste0(fl,collapse="\n")
}
