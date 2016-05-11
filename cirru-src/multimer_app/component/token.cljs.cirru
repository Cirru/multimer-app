
ns multimer-app.component.token $ :require
  [] hsl.core :refer $ [] hsl
  [] respo.alias :refer $ [] create-comp div span
  [] multimer-app.util.measure :refer $ [] text-width

defn handle-change (coord filename)
  fn (simple-event dispatch)
    dispatch :edit/update-token $ [] filename coord (:value simple-event)

defn handle-focus (coord filename)
  fn (simple-event dispatch)
    dispatch :state/focus $ [] filename coord

defn render
  token coord filename focused
  fn (state mutate)
    let
      (focused? $ = focused coord)
        blank? $ or (= token |)
          > (.indexOf token "| ")
            , 0

      span $ {} :style
        {} (:width |auto)
          :font-family "|Menlo, Consolas"
          :font-size |14px
          :margin "|0 4px"
          :border |none
          :background-color $ if focused?
            hsl 0 0 84
            if blank?
              hsl 0 80 80
              hsl 0 0 94

          :outline $ if focused?
            str "|1px solid " $ hsl 0 90 80
            , |none
          :padding "|0 1px"
          :line-height 1.6
          :display |inline-block
          :min-width |16px
          :min-height |16px
          :text-align |center

        , :attrs
        {} (:inner-text token)
          :z-index 1
          :class-name $ if focused? |cursor nil
        , :event
        {} $ :click (handle-focus coord filename)

def comp-token $ create-comp :token render
