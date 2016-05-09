
ns multimer-app.util.element $ :require
  [] respo.alias :refer $ [] span

defn text (x)
  span $ {} :attrs ({} :inner-text x)
