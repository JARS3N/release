# to fix the NaNs created by rm.na in means
nan2na<-Vectorize(
    function(u){
      if(is.nan(u)){NA}else{u}
    }
  )
