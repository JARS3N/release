pull_wet_qc <- function(table,lot,instrument) {
 require(RMySQL)
  str<-"SELECT * FROM xtblx where Lot = 'xlotx' AND Inst = 'xinstx';"
  str <- gsub("xtblx", table,
              gsub("xlotx", lot,
                   gsub("xinstx", instrument,
                        str)))

  db <- adminKraken::con_mysql()
  q <- RMySQL::dbSendQuery(db, str)
  fet <- RMySQL::fetch(q,n=-1)
  RMySQL::dbClearResult(q)
  RMySQL::dbDisconnect(db)
  fet
}
