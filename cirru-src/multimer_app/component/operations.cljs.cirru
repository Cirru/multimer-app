
ns multimer-app.component.operations $ :require
  [] hsl.core :refer $ [] hsl
  [] respo.alias :refer $ [] create-comp div span button
  [] multimer-app.style.widget :as widget

def style-button $ merge widget/button
  {}
    :background-color $ hsl 170 80 40
    :font-family "|Menlo, Consolas"
    :margin "|6px 6px"
    :font-size |14px
    :line-height |32px
    :flex 1

defn handle-close (focus)
  fn (simple-event dispatch)
    dispatch :state/focus $ [] (first focus)
      , nil

defn handle-save (filename)
  fn (e dispatch)
    dispatch :effect/save-file filename

defn render-button
  guide command focus change
  let
    (handler $ fn (simple-event dispatch) (dispatch command focus) (change :draft |))

    button $ {} :style style-button :attrs ({} :inner-text guide)
      , :event
      {} :click handler

defn render (focus change)
  fn (state mutate)
    div
      {} :style $ {} (:margin "|0 0 6px 0")
      render-button |fold :edit/fold focus change
      render-button |unfold :edit/unfold focus change
      render-button |remove :edit/remove focus change
      render-button |insert :edit/insert focus change
      render-button |expression :edit/new-expression focus change
      render-button |append :edit/append focus change
      render-button |out :state/out nil change
      render-button |newline :edit/append-line focus change
      render-button |line :edit/prepend-line focus change
      render-button |prepend :edit/prepend focus change
      button $ {} :style style-button :event
        {} :click $ handle-save (first focus)
        , :attrs
        {} :inner-text |save

      button $ {} :style style-button :event
        {} :click $ handle-close focus
        , :attrs
        {} :inner-text |close

def comp-operations $ create-comp :operations render
