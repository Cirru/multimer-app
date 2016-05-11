
ns multimer-app.component.editor $ :require
  [] hsl.core :refer $ [] hsl
  [] respo.alias :refer $ [] create-comp div span pre button input
  [] multimer-app.util.element :refer $ [] text
  [] multimer-app.component.expression :refer $ [] comp-expression
  [] multimer-app.component.movable-type :refer $ [] comp-movable-type
  [] respo.component.debug :refer $ [] comp-debug
  [] multimer-app.style.widget :as widget

def style-button $ merge widget/button
  {}
    :background-color $ hsl 300 80 60
    :font-family "|Menlo, Consolas"
    :margin "|6px 4px"

defn handle-close (focus)
  fn (simple-event dispatch)
    dispatch :state/focus $ [] (first focus)
      , nil

defn handle-save (filename)
  fn (e dispatch)
    dispatch :effect/save-file filename

defn render-button (guide command focus)
  let
    (handler $ fn (simple-event dispatch) (dispatch command focus))

    button $ {} :style style-button :attrs ({} :inner-text guide)
      , :event
      {} :click handler

defn render
  file focus target-expression vocabulary
  fn (state mutate)
    div
      {} :style $ {} (:height |100%)
        :display |flex
        :flex-direction |column
      div
        {} :style $ {} (:padding "|200px 8px")
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
          {} :style $ {} (:display |flex)
            :flex-direction |row
          render-button "|new expr" :edit/new-expression focus
          render-button |append :edit/append focus
          render-button |remove :edit/remove focus
          render-button |insert :edit/insert focus
          render-button |prepend :edit/prepend focus
          render-button |fold :edit/fold focus
          render-button |unfold :edit/unfold focus
          render-button |newline :edit/append-line focus
          render-button |line :edit/prepend-line focus
          render-button |out :state/out nil
          button $ {} :style style-button :event
            {} :click $ handle-save (first focus)
            , :attrs
            {} :inner-text |save

          button $ {} :style style-button :event
            {} :click $ handle-close focus
            , :attrs
            {} :inner-text |close

        div
          {} :style $ {}
          div ({})
            comp-movable-type
              into (hash-set)
                flatten $ :tree file
              , focus vocabulary

def comp-editor $ create-comp :editor render
