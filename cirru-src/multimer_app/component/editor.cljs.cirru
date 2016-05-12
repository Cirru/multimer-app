
ns multimer-app.component.editor $ :require
  [] hsl.core :refer $ [] hsl
  [] respo.alias :refer $ [] create-comp div span pre button input
  [] multimer-app.util.element :refer $ [] text
  [] multimer-app.component.expression :refer $ [] comp-expression
  [] multimer-app.component.movable-type :refer $ [] comp-movable-type
  [] respo.component.debug :refer $ [] comp-debug
  [] multimer-app.style.widget :as widget

defn render (file focus target-expression)
  fn (state mutate)
    div
      {} :style $ {} (:height |100%)
        :display |flex
        :flex-direction |column
      div
        {} :style $ {} (:padding "|160px 8px")
          :flex 1
          :overflow |auto
        comp-expression target-expression
          subvec (last focus)
            , 0 1
          first focus
          last focus
          , true false

      div
        {} :style $ {} (:display |flex)
          :flex-direction |column
        div
          {} :style $ {}
          div ({})
            comp-movable-type
              into (hash-set)
                flatten $ :tree file
              , focus

def comp-editor $ create-comp :editor render
