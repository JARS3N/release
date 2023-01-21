revised_ui <- function() {
  library(shiny)
  fluidPage(
    titlePanel('Download a PDF report'),
    shinyjs::useShinyjs(),
    sidebarLayout(
      sidebarPanel(
        selectInput(
          "lotselect",
          label = "Lot",
          choices = "...",
          selected = 1
        ),
        selectInput(
          "selInst",
          label = h3("QC Instrument"),
          choices = "..."
        ),
        actionButton("Compiler", "compile data"),
        shinyjs::hidden(downloadButton('downloadData', 'print PDF'))
      ),
      mainPanel(h3(textOutput("lotchoice")),
                DT::dataTableOutput("sumtbl"))
    )
  )
}
