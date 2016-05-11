
ns multimer-app.component.operations $ :require
  [] hsl.core :refer $ [] hsl
  [] respo.alias :refer $ [] create-comp div span button
  [] multimer-app.style.widget :as widget

def style-button $ merge widget/button
  {}
    :background-color $ hsl 300 80 60
    :font-family "|Menlo, Consolas"
    :margin "|6px 4px"
    :font-size |10px
    :line-height |32px

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

defn render (focus)
  fn (state mutate)
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

def comp-operations $ create-comp :operations render
