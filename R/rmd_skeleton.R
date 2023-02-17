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
  #  "### Deviation Approved by:  ",
    "### Reference the following site-specific procedures when deviation from the process is applicable:",
"#### SBS-1303-600 Procedure Deviation Process, SBS-1302-700 Form Deviation, SBS-1301-700 Request Log:",
    sig_section
  )
}
