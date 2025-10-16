lot_inst_combo <- function(LOT) {
  library(dplyr)
  if (is.null(LOT) || !nzchar(LOT)) {
    return(tibble(Lot = character(), Inst = character()))
  }
  
  type <- toupper(substr(LOT, 1, 1))
  map  <- c(B = "xfe24wetqc", C = "xfpwetqc", W = "xfe96wetqc")
  if (!type %in% names(map)) {
    return(tibble(Lot = character(), Inst = character()))
  }
  
  tbl_name <- unname(map[type])
  
  con <- adminKraken::con_dplyr()
  dplyr::tbl(con, tbl_name) %>%
    dplyr::filter(Lot == LOT) %>%
    dplyr::select(Lot, Inst) %>%
    dplyr::distinct() %>%
    dplyr::collect()
}



serverh <- function() {
  library(shiny)
  library(dplyr)
  library(release)
  
  
  HOLD <- new.env()
  function(input, output, session) {
    observeEvent(input$lotselect, {
      a <- lot_inst_combo(input$lotselect)
      updateSelectizeInput(
        session = session,
        inputId = "selInst",
        choices =  a$Inst,
        selected = NULL
      )
      
    })
    
    observeEvent(input$Compiler, {
      HOLD$release <- release$new(input$lotselect, input$selInst)
      output$sumtbl <- DT::renderDataTable({
        HOLD$release$ctg_means
      }, options = list(dom = 't', pageLength = 11), rownames = FALSE)
    })
    
#########
    output$downloadData <- downloadHandler(
      filename = function() {
        req(!is.null(HOLD$release))
        paste0(
          "RFS_Lot-", HOLD$release$Lot,
          "_Inst-", HOLD$release$Inst, "_",
          Sys.Date(), ".pdf"
        )
      },
      content = function(file) {
        req(!is.null(HOLD$release))
        tmp_rmd  <- tempfile(fileext = ".Rmd")
        out_dir  <- tempdir()
        on.exit(unlink(tmp_rmd, force = TRUE), add = TRUE)
        
        # Write the Rmd contents
        writeLines(HOLD$release$RMD(), tmp_rmd)
        
        # Render to a self-contained HTML so Chrome can print it reliably
        out_html <- rmarkdown::render(
          input         = tmp_rmd,
          output_format = rmarkdown::html_document(self_contained = TRUE),
          output_dir    = out_dir,
          clean         = TRUE,
          quiet         = TRUE,
          envir         = new.env(parent = globalenv())
        )
        
        # Use headless Chrome via pagedown to "print" HTML -> PDF directly to `file`
        # (Install once: install.packages("pagedown"))
        pagedown::chrome_print(input = out_html, output = file)
        
        # Optional: reset state
        HOLD$release <- NULL
        output$sumtbl <- DT::renderDataTable(NULL)
      }
    )
    
    
#########    
  }
}


uih<-function(){
  library(shiny)
  fluidPage(
    titlePanel('Download a PDF report'),
    shinyjs::useShinyjs(),
    sidebarLayout(
      sidebarPanel(
        textInput(inputId= "lotselect", label="Input Lot", value = "", width = NULL, placeholder = NULL),
        selectInput(
          "selInst",
          label = h3("QC Instrument"),
          choices = "..."
        ),
        actionButton("Compiler", "compile data"),
        downloadLink("downloadData", "Download")
      ),
      mainPanel(h3(textOutput("lotchoice")),
                DT::dataTableOutput("sumtbl"))
    )
  )
}

apph <-function(){
shinyApp(ui = release::uih(), server = release::serverh())
  }
