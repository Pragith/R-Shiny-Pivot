library(shiny)
library(shinysky)

shinyUI(basicPage(
  headerPanel("Pivot Tables using R")
           ,div(class="row-fluid ",
                div(class="well container-fluid"   ,  
                    div(class="container span3",
                        select2Input("rowsInp","Rows",
                                     choices=c("a","b","c"),
                                     selected=c("Race","Education"))
                        ,select2Input("colsInp","Columns",
                                     choices=c("a","b","c"),
                                     selected=c("Sex"))
                        ,select2Input("valsInp","Values",
                                     choices=c("a","b","c"),
                                     selected=c("UsualWeeklyEarnings","UsualHoursWorked"))
                    ),
                    div(class="container span3"
                        ,helpText("rowsInp")
                        ,actionButton("updateselect2","Update")
                        ,shinyalert("shinyalert4")
                    )
                ))
  ,tableOutput("resultTable")
)
)
