
ns multimer-app.component.container $ :require
  [] respo.alias :refer $ [] create-comp div span pre
  [] multimer-app.component.join :refer $ [] comp-join
  [] multimer-app.component.editor :refer $ [] comp-editor

defn render (store)
  fn (state mutate)
    div
      {} :style $ {} (:width |100%)
        :height |100%
      if
        some? $ :profile store
        comp-editor $ :files store
        comp-join

def comp-container $ create-comp :container render
