library(shiny)
library(shinysky)
library(sqldf)

shinyServer(function(input, output, session) {
  
  source("SQL_Gen.R")
  
  data = read.csv("dataset.csv")
  colnames(data) = gsub(".","",colnames(data), fixed=TRUE)
  data.cols = colnames(data)
  
  # select2
  observe({
    if (input$updateselect2 == 0) 
      return()
    
    #updateSelect2Input(session, "select2Input1", choices = c("d", "e", "f"), selected = c("f","d"), label = "hello")
    updateSelect2Input(session, "rowsInp", choices = data.cols, label = "Rows")
    updateSelect2Input(session, "colsInp", choices = data.cols, label = "Cols")
    updateSelect2Input(session, "valsInp", choices = data.cols, label = "Vals")
    
  })
  
  
  observe({
    Rows <<- paste(input$rowsInp, collapse = ", ")
    Cols <<- paste(input$colsInp, collapse = ",")
    Vals <<- paste(input$valsInp, collapse = ",")
  })
  
  observeEvent(input$updateselect2, {
    ##  showshinyalert(session, "shinyalert4", genFn("data", Rows, Cols, Vals), "info")
    output$resultTable = renderTable({
      res = sqldf(genFn("data", Rows, Cols, Vals))
    })
  })
  
  
  
})
