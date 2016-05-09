
ns multimer-app.component.editor $ :require
  [] respo.alias :refer $ [] create-comp div span
  [] multimer-app.util.element :refer $ [] text

defn render (files)
  fn (state mutate)
    div ({})
      text $ pr-str files

def comp-editor $ create-comp :editor render
