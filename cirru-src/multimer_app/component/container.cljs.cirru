
ns multimer-app.component.container $ :require
  [] respo.alias :refer $ [] create-comp div

defn render (store)
  fn (state mutate)
    div $ {}

def comp-container $ create-comp :container render
