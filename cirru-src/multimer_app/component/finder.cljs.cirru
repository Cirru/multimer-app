
ns multimer-app.component.finder $ :require
  [] respo.alias :refer $ [] create-comp div span
  [] multimer-app.component.file-menu :refer $ [] comp-file-menu
  [] multimer-app.component.definition-menu :refer $ [] comp-definition-menu

defn render (files focus file)
  fn (state mutate)
    div ({})
      div
        {} :style $ {} (:display |flex)
          :width |100%
        comp-file-menu (keys files)
          , focus
        comp-definition-menu (:tree file)
          , focus

def comp-finder $ create-comp :finder render
