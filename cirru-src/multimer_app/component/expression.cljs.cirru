
ns multimer-app.component.expression $ :require
  [] hsl.core :refer $ [] hsl
  [] respo.alias :refer $ [] create-comp div
  [] multimer-app.component.token :refer $ [] comp-token

declare comp-expression

defn handle-focus (coord filename)
  fn (simple-event dispatch)
    dispatch :state/focus $ [] filename coord

defn render
  expression coord filename focused tail? after-vector?
  fn (state mutate)
    let
      (short? $ <= (count expression) (, 4))
        simple? $ every? string? expression
        inline? $ and short? simple? (not after-vector?)
        focused? $ = focused coord

      div
        {} :style
          {}
            :display $ if (or inline? tail?)
              , |inline-block |block
            :margin $ if tail? "|2px 2px 0 16px"
              if (or inline? tail?)
                , "|2px 2px" "|2px 2px 0px 16px"

            :padding $ if
              and inline? $ not tail?
              , "|0px 4px 2px 4px" "|0 0 0 4px"
            :border-style |solid
            :border-color $ hsl 0 0 86
            :border-width $ if tail? "|0 0 0 1px"
              if inline? "|0 0 1px 0" "|0 0 0 1px"
            :background-color $ hsl 0 0 94
            :outline $ if focused?
              str "|1px solid " $ hsl 0 90 80
              , |none
            :vertical-align |top
            :min-height |16px
            :min-width |16px

          , :event
          {} :click $ handle-focus coord filename
          , :attrs
          {} :z-index |1 :class-name $ if focused? |cursor nil

        ->> expression
          map-indexed $ fn (index child)
            let
              (child-coord $ conj coord index)
                after-v? $ and (> index 0)
                  let
                    (last-child $ get expression (dec index))

                    vector? last-child

                tail-child? $ and (not tail?)
                  = index $ dec (count expression)

              [] index $ if (vector? child)
                comp-expression child child-coord filename focused tail-child? after-v?
                comp-token child child-coord filename focused

          into $ sorted-map

def comp-expression $ create-comp :expression render
