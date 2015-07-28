
# SUM(CASE 
# WHEN Sex == "Female" THEN `Usual.Hours.Worked`
# END) AS FemaleUsualHoursWorked
# ,SUM(CASE 
# WHEN Sex == "Female" THEN `Usual.Weekly.Earnings`
# END) AS FemaleUsualWeeklyEarnings
# 
# ,SUM(CASE 
# WHEN Sex == "Male" THEN `Usual.Hours.Worked`
# END) AS MaleUsualHoursWorked
# ,SUM(CASE 
# WHEN Sex == "Male" THEN `Usual.Weekly.Earnings`
# END) AS MaleUsualWeeklyEarnings
# 

# Format:
#   SUM(CASE
#       WHEN Column1 == "ColVal1" THEN "Value1"
#       END) AS ColVal1Value1
#   SUM(CASE
#       WHEN Column1 == "ColVal1" THEN "Value2"
#       END) AS ColVal1Value2
#   SUM(CASE
#       WHEN Column1 == "ColVal2" THEN "Value1"
#       END) AS ColVal2Value1
#   SUM(CASE
#       WHEN Column1 == "ColVal2" THEN "Value2"
#       END) AS ColVal2Value2

colsFn = function(dataset, c, v){
  #c = "State, Sex"
  #v = "UsualHoursWorked,UsualWeeklyEarnings"
  colsQ <<- list()
  #dataset = "data"
  
  colvals = sqldf(paste("SELECT DISTINCT",c,"FROM",dataset))
  
  cols = strsplit(c, ",")
  vals = strsplit(v, ",")
  
  for (Column in unlist(cols)){
    for (ColVal in colvals){
      for (Value in unlist(vals)){
        colsQ = c(colsQ,paste('SUM(CASE WHEN ',Column,' =="',colvals[ColVal,],'" THEN "',Value,'" END) AS ',paste(colvals[ColVal,],Value,sep="_"),sep=""))
      }
    }
  }
  return (paste(unlist(colsQ),collapse=", "))
}


genFn = function(dataset, r, c, v){
  
  ##  Start with SELECT
  q = "SELECT "
  
  ##  Add in the "Rows"
  q = paste(q,r,sep="")
  
  ##  Add in "Columns" and "Values"
  q = paste(q, ",", colsFn(dataset,c,v))
  
  ##  Add "From"
  q = paste(q," FROM ",dataset,sep="")
  
  ##  Add the Rows in "Group By"
  q = paste(q, " GROUP BY ",r,sep="")
  
  q
}



filtFn = function(){}
