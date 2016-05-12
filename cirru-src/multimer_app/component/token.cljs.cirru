
ns multimer-app.component.token $ :require
  [] hsl.core :refer $ [] hsl
  [] respo.alias :refer $ [] create-comp div span
  [] multimer-app.util.event :refer $ [] click-event

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
            hsl 0 0 100 0.2
            if blank?
              hsl 0 30 90 0.2
              hsl 0 0 0 0

          :outline $ if focused?
            str "|1px solid " $ hsl 0 90 80
            , |none
          :padding "|2px 4px"
          :line-height 1.6
          :display |inline-block
          :min-width |16px
          :min-height |24px
          :text-align |center
          :white-space |pre
          :color $ hsl 0 0 100
          :vertical-align |top

        , :attrs
        {} (:inner-text token)
          :z-index 1
          :class-name $ if focused? |cursor nil
        , :event
        {} $ click-event (handle-focus coord filename)

def comp-token $ create-comp :token render
