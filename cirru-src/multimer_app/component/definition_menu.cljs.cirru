
ns multimer-app.component.definition-menu $ :require
  [] hsl.core :refer $ [] hsl
  [] respo.alias :refer $ [] create-comp div
  [] multimer-app.util.element :refer $ [] text

defn handle-toggle (mutate)
  fn (state dispatch)
    mutate

defn handle-click (index focus mutate)
  fn (simple-event dispatch)
    dispatch :state/focus $ assoc focus 1 ([] index)
    mutate

defn render (tree focus)
  fn (state mutate)
    div
      {} :style $ {} (:position |relative)
        :background-color $ hsl 300 80 94
        :color $ hsl 0 0 40
        :line-height 2
        :width |300px
        :cursor |pointer
        :font-family "|Menlo, Consolas"
        :font-size |16px
        :white-space |nowrap
      div
        {} :style
          {} (:padding "|0 8px")
            :overflow |hidden
          , :event
          {} :click $ handle-toggle mutate

        text $ let
          (first-pos $ first (last focus))
            selected-expression $ get tree first-pos

          or selected-expression "|no selected expression"

      if state $ div
        {} :style $ {} (:position |absolute)
          :background-color $ hsl 300 60 80
          :color $ hsl 0 0 100
          :width |100%
          :padding "|0 8px"
          :cursor |pointer
        ->> tree
          map-indexed $ fn (index line)
            [] index $ div
              {} :event $ {} :click
                handle-click index focus mutate
              text line

          into $ sorted-map

def comp-definition-menu $ create-comp :definition-menu render
