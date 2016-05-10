
ns multimer-app.component.definition-menu $ :require
  [] hsl.core :refer $ [] hsl
  [] respo.alias :refer $ [] create-comp div
  [] multimer-app.util.element :refer $ [] text

defn handle-click (index focus mutate)
  fn (simple-event dispatch)
    dispatch :state/focus $ assoc focus 1 ([] index)
    mutate

defn render (tree focus)
  fn (state mutate)
    div
      {} :style $ {} (:font-family "|Menlo, Consolas")
        :white-space |nowrap
      div
        {} :style $ {} (:cursor |pointer)
          :font-size |14px
        ->> tree
          map-indexed $ fn (index line)
            [] index $ div
              {} :style
                {} (:line-height 2.4)
                  :margin |4px
                  :background-color $ hsl 300 60 60
                  :color $ hsl 0 0 100
                  :padding "|0 8px"
                , :event
                {} :click $ handle-click index focus mutate

              text $ subs (str line)
                , 0 80

          into $ sorted-map

def comp-definition-menu $ create-comp :definition-menu render
