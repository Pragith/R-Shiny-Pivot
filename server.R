library(shiny)
library(shinysky)
library(sqldf)

shinyServer(function(input, output, session) {
  
  source("SQL_Gen.R")
  
  readData = reactive({
    read.csv("dataset.csv")  
  })
  
  data.cols = reactive({
    d = gsub(".","",colnames(readData()), fixed=TRUE); d
  })

  observe({
    if (input$updateselect2 == 0) 
      return()
    
    updateSelect2Input(session, "rowsInp", choices = data.cols(), label = "Rows")
    updateSelect2Input(session, "colsInp", choices = data.cols(), label = "Cols")
    updateSelect2Input(session, "valsInp", choices = data.cols(), label = "Vals")
    
  })
  
  observe({
    Rows <<- paste(input$rowsInp, collapse = ", ")
    Cols <<- paste(input$colsInp, collapse = ",")
    Vals <<- paste(input$valsInp, collapse = ",")
  })
  
  observeEvent(input$updateselect2, {
    ##  showshinyalert(session, "shinyalert4", genFn("data", Rows, Cols, Vals), "info")
    output$resultTable = renderTable({
      data = readData()
      sqldf(genFn("data", data, Rows, Cols, Vals))
    })
  })
  
  
  
})
