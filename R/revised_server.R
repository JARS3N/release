revised_server <- function() {
  library(shiny)
  library(dplyr)
  library(release)
  db <- adminKraken::con_dplyr()
  xxx <- tbl(db, "wetqclots") %>% collect()
  rm(db)
  HOLD <- new.env()
  function(input, output, session) {
   # onStop(function() {
   #   rm(list = ls())
   # })


    updateSelectizeInput(
      session,
      inputId = "lotselect",
      label = "Select Lot",
      choices = xxx$Lot,
      selected = NULL
    )
    observeEvent(input$lotselect, {
      updateSelectizeInput(
        session = session,
        inputId = "selInst",
        choices =  filter(xxx, Lot == input$lotselect)$Inst,
        selected = NULL
      )
      # output$sumtbl <- NULL
      # HOLD$release <- NULL
    })

    observeEvent(input$Compiler, {
      HOLD$release <- release$new(input$lotselect,
                                  input$selInst)
      output$sumtbl <- DT::renderDataTable({
        HOLD$release$ctg_means
      }, options = list(dom = 't', pageLength = 11),
      rownames = FALSE)
      #shinyjs::show("downloadData")
    })

    output$downloadData <- downloadHandler(
      filename <- function(lot=HOLD$release$Lot,inst=HOLD$release$Inst){
        paste0("RFS_Lot-",lot,"_Inst-",inst,"_",Sys.Date(),".pdf")},
      content <- function(file) {
        write(HOLD$release$RMD(), file = "temp.rmd")
        out <- rmarkdown::render("temp.rmd","pdf_document")
        file.copy("temp.pdf", file)
        unlink("temp.rmd")
        unlink("temp.pdf")
        HOLD$release <- NULL
        output$sumtbl <- NULL
      }
    )
  }
}
