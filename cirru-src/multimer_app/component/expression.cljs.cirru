
ns multimer-app.component.expression $ :require
  [] hsl.core :refer $ [] hsl
  [] respo.alias :refer $ [] create-comp div
  [] multimer-app.component.token :refer $ [] comp-token

declare comp-expression

defn handle-focus (coord filename)
  fn (simple-event dispatch)
    dispatch :state/focus $ [] filename coord

defn render
  expression coord filename focused tail?
  fn (state mutate)
    let
      (short? $ < (count expression) (, 4))
        simple? $ every? string? expression
        inline? $ and short? simple?
        focused? $ = focused coord

      div
        {} :style
          {}
            :display $ if (or inline? tail?)
              , |inline-block |block
            :margin "|0 4px"
            :padding $ if inline? "|4px 16px 4px 4px" "|4px 16px 4px 4px"
            :border $ str "|1px solid "
              hsl 0 0 86
            :background-color $ hsl 0 0 94
            :outline $ if focused?
              str "|1px solid " $ hsl 0 90 70
              , |none
            :vertical-align |top

          , :event
          {} :click $ handle-focus coord filename
          , :attrs
          {} :z-index |1 :class-name $ if focused? |cursor nil

        ->> expression
          map-indexed $ fn (index child)
            let
              (child-coord $ conj coord index)
                last-child? $ and (not tail?)
                  = index $ dec (count expression)

              [] index $ if (vector? child)
                comp-expression child child-coord filename focused last-child?
                comp-token child child-coord filename focused

          into $ sorted-map

def comp-expression $ create-comp :expression render
