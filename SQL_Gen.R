colsFn = function(d, c, v){
  colsQ <<- list()
  data = d
  colvals = sqldf(paste("SELECT DISTINCT",c,"FROM data"))
  
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


genFn = function(dataset, data, r, c, v){

  ##  Start with SELECT
  q = "SELECT "
  
  ##  Add in the "Rows"
  q = paste(q,r,sep="")
  
  ##  Add in "Columns" and "Values"
  q = paste(q, ",", colsFn(data,c,v))
  
  ##  Add "From"
  q = paste(q," FROM ",dataset,sep="")
  
  ##  Add the Rows in "Group By"
  q = paste(q, " GROUP BY ",r,sep="")
  
  q
}

#filtFn = function(){}
