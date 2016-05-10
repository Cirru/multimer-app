
ns multimer-app.component.finder $ :require
  [] respo.alias :refer $ [] create-comp div span button
  [] multimer-app.component.file-menu :refer $ [] comp-file-menu
  [] multimer-app.component.definition-menu :refer $ [] comp-definition-menu
  [] multimer-app.util.element :refer $ [] text
  [] multimer-app.style.widget :as widget

defn handle-back (e dispatch)
  dispatch :state/focus nil

defn render (files focus file)
  fn (state mutate)
    div ({})
      div
        {} :style $ {} (:display |flex)
          :width |100%
        if
          not $ some? file
          comp-file-menu (keys files)
            , focus
          div ({})
            div
              {} :style $ {} (:display |inline-block)
                :font-size |14px
                :font-family |Menlo,Consolas
                :padding "|0 8px"
              text $ :name file

            button $ {} :style
              merge widget/button $ {}
              , :attrs
              {} :inner-text |back
              , :event
              {} :click handle-back
            comp-definition-menu (:tree file)
              , focus

def comp-finder $ create-comp :finder render
