rmd_skeleton<-function(){
  dash<-"---  "
  blank<-"  "
  end_tick<-"```  "
  stars<-"****  "
  codeblock<-"```{}  "
  sig_section<- c(stars,codeblock,rep(blank,3),end_tick,blank)
  fl<-c(
    dash,
    "title: \"Cartridge QC Lot Release\"  " ,
    "output: html_document  " ,
    dash,
    "## Lot: %lotline%",
    "### QC Instrument: %instline%",
    "  ",
    "#### %Date%  ",
    "  ",
    "%table%",
    rep(blank,3),
    "### Approved for Release by:  " ,
    sig_section,
    "### Deviation Approved by:  ",
    sig_section
  )
}
