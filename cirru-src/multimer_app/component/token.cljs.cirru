
ns multimer-app.component.token $ :require
  [] hsl.core :refer $ [] hsl
  [] respo.alias :refer $ [] create-comp div span input
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

      input $ {} :style
        {}
          :width $ str
            + 16 $ text-width token "|Menlo, Consolas" 16
            , |px
          :font-family "|Menlo, Consolas"
          :font-size |16px
          :margin "|0 8px"
          :border |none
          :outline |none
          :background-color $ if focused?
            hsl 0 0 84
            if blank?
              hsl 0 80 80
              hsl 0 0 94

          :outline $ if focused?
            str "|1px solid " $ hsl 0 90 60
            , |none
          :padding "|0 8px"
          :line-height 1.4

        , :attrs
        {} :value token :class-name $ if focused? |cursor nil
        , :event
        {}
          :input $ handle-change coord filename
          :click $ handle-focus coord filename

def comp-token $ create-comp :token render
