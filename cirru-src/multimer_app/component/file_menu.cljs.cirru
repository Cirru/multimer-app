
ns multimer-app.component.file-menu $ :require
  [] hsl.core :refer $ [] hsl
  [] respo.alias :refer $ [] create-comp div
  [] multimer-app.util.element :refer $ [] text
  [] respo.component.debug :refer $ [] comp-debug

defn handle-focus (filename mutate)
  fn (simple-event dispatch)
    dispatch :state/focus $ [] filename nil
    mutate

defn render (filenames focus)
  fn (state mutate)
    div
      {} :style $ {} (:font-family "|Menlo, Consolas")
        :padding "|20px 8px"
      -- comp-debug focus $ {} (:z-index 100)
      let $
        selected-file $ if (some? focus)
          first focus

      div ({})
        ->> filenames
          map-indexed $ fn (index filename)
            [] index $ div
              {} :style
                {} (:padding "|0 8px")
                  :line-height 2.4
                  :cursor |pointer
                  :margin |4px
                  :background-color $ hsl 200 60 60
                  :color $ hsl 0 0 100
                , :event
                {} :click $ handle-focus filename mutate

              text filename

          into $ sorted-map

def comp-file-menu $ create-comp :file-menu render
