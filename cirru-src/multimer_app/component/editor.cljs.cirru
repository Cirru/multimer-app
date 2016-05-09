
ns multimer-app.component.editor $ :require
  [] hsl.core :refer $ [] hsl
  [] respo.alias :refer $ [] create-comp div span pre button
  [] multimer-app.util.element :refer $ [] text
  [] multimer-app.component.file-menu :refer $ [] comp-file-menu
  [] multimer-app.component.definition-menu :refer $ [] comp-definition-menu
  [] multimer-app.component.expression :refer $ [] comp-expression
  [] respo.component.debug :refer $ [] comp-debug

def style-button $ {} (:display |block)
  :border |none
  :background-color $ hsl 200 80 80
  :color $ hsl 0 0 100
  :font-size |16px
  :line-height 2
  :font-family "|Menlo, Consolas"
  :margin |10px
  :outline |none

defn handle-append (focus)
  fn (simple-event dispatch)
    dispatch :edit/append focus

defn handle-prepend (focus)
  fn (simple-event dispatch)
    dispatch :edit/prepend focus

defn handle-insert (focus)
  fn (simple-event dispatch)
    dispatch :edit/insert focus

defn handle-remove (focus)
  fn (simple-event dispatch)
    dispatch :edit/remove focus

defn handle-fold (focus)
  fn (simple-event dispatch)
    dispatch :edit/fold focus

defn handle-unfold (focus)
  fn (simple-event dispatch)
    dispatch :edit/unfold focus

defn handle-append-line (focus)
  fn (simple-event dispatch)
    dispatch :edit/append-line focus

defn handle-prepend-line (focus)
  fn (simple-event dispatch)
    dispatch :edit/prepend-line focus

defn render (files focus file)
  fn (state mutate)
    div
      {} :style $ {} :height |100%
      div
        {} :style $ {} (:display |flex)
          :width |100%
        comp-file-menu (keys files)
          , focus
        comp-definition-menu (:tree file)
          , focus

      let
        (at-line? $ > (count $ last focus) (, 0))
          target-expression $ if
            and (some? file)
              , at-line?
            get (:tree file)
              first $ last focus
            , nil

        if (some? file)
          if (some? target-expression)
            div
              {} :style $ {} (:display |flex)
                :height |100%
              div
                {} :style $ {} (:display |flex)
                  :flex-direction |column
                  :justify-content |center
                button $ {} :style style-button :attrs ({} :inner-text |Append)
                  , :event
                  {} :click $ handle-append focus
                button $ {} :style style-button :attrs ({} :inner-text |Prepend)
                  , :event
                  {} :click $ handle-prepend focus
                button $ {} :style style-button :attrs ({} :inner-text |Insert)
                  , :event
                  {} :click $ handle-insert focus
                button $ {} :style style-button :attrs ({} :inner-text |Remove)
                  , :event
                  {} :click $ handle-remove focus
                button $ {} :style style-button :attrs ({} :inner-text |Fold)
                  , :event
                  {} :click $ handle-fold focus
                button $ {} :style style-button :attrs ({} :inner-text |Unfold)
                  , :event
                  {} :click $ handle-unfold focus
                button $ {} :style style-button :attrs ({} :inner-text |Newline)
                  , :event
                  {} :click $ handle-append-line focus
                button $ {} :style style-button :attrs ({} :inner-text |Line)
                  , :event
                  {} :click $ handle-prepend-line focus

              div
                {} :style $ {} (:padding "|200px 40px")
                comp-expression target-expression
                  subvec (last focus)
                    , 0 1
                  first focus
                  last focus

            div ({})
              text $ pr-str (:tree file)

          div ({})
            text "|no file selected"

      -- comp-debug focus
      -- comp-debug (:tree file)
        {} $ :top |80px

def comp-editor $ create-comp :editor render
