
ns multimer-app.component.expression $ :require
  [] hsl.core :refer $ [] hsl
  [] respo.alias :refer $ [] create-comp div
  [] multimer-app.component.token :refer $ [] comp-token

declare comp-expression

defn handle-focus (coord filename)
  fn (simple-event dispatch)
    dispatch :state/focus $ [] filename coord

defn render
  expression coord filename focused
  fn (state mutate)
    let
      (short? $ < (count expression) (, 4))
        simple? $ every? string? expression
        inline? $ and short? simple?
        focused? $ = focused coord

      div
        {} :style
          {}
            :display $ if inline? |inline-block |block
            :margin "|0 4px"
            :padding $ if inline? "|8px 8px" "|8px 18px"
            :border $ str "|1px solid "
              hsl 0 0 70
            :background-color $ if focused?
              hsl 0 0 84
              hsl 0 0 94

          , :event
          {} :click $ handle-focus coord filename
          , :attrs
          {} :z-index |1

        ->> expression
          map-indexed $ fn (index child)
            let
              (child-coord $ conj coord index)
              [] index $ if (vector? child)
                comp-expression child child-coord filename focused
                comp-token child child-coord filename focused

          into $ sorted-map

def comp-expression $ create-comp :expression render
