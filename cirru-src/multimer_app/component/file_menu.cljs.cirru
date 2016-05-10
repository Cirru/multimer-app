
ns multimer-app.component.file-menu $ :require
  [] hsl.core :refer $ [] hsl
  [] respo.alias :refer $ [] create-comp div
  [] multimer-app.util.element :refer $ [] text
  [] respo.component.debug :refer $ [] comp-debug

defn handle-toggle (mutate)
  fn (simple-event dispatch)
    mutate

defn handle-focus (filename mutate)
  fn (simple-event dispatch)
    dispatch :state/focus $ [] filename nil
    mutate

defn render (filenames focus)
  fn (state mutate)
    div
      {} :style $ {} (:width |400px)
        :position |relative
        :background-color $ hsl 200 80 94
        :color $ hsl 0 0 40
        :line-height 2
        :cursor |pointer
        :font-size |16px
        :font-family "|Menlo, Consolas"
      -- comp-debug focus $ {} (:z-index 100)
      let
        (selected-file $ if (some? focus) (first focus))

        div
          {} :style
            {} $ :padding "|0 8px"
            , :event
            {} :click $ handle-toggle mutate
          text $ or selected-file "|no file selected"

      div
        {} :style $ {}
          :background-color $ hsl 200 60 60
          :color $ hsl 0 0 100
          :width |100%
          :position |absolute
        ->> filenames
          map-indexed $ fn (index filename)
            [] index $ div
              {} :style
                {} (:padding "|0 8px")
                  :line-height 2
                  :cursor |pointer
                , :event
                {} :click $ handle-focus filename mutate

              text filename

          into $ sorted-map

def comp-file-menu $ create-comp :file-menu render
