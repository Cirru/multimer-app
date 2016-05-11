
ns multimer-app.component.container $ :require
  [] respo.alias :refer $ [] create-comp div span pre
  [] multimer-app.component.join :refer $ [] comp-join
  [] multimer-app.component.editor :refer $ [] comp-editor
  [] multimer-app.component.finder :refer $ [] comp-finder
  [] respo.component.debug :refer $ [] comp-debug

defn render (store)
  fn (state mutate)
    div
      {} :style $ {} (:width |100%)
        :height |100%
      -- comp-debug store $ {}
      if
        some? $ :profile store
        let
          (focus $ :focus (:state store))
            maybe-file $ :file store
            maybe-coord $ if (some? focus)
              last focus
              , nil
            maybe-line $ if (some? maybe-coord)
              first maybe-coord
              , nil
            maybe-expression $ if
              and (some? maybe-file)
                some? maybe-line
              get (:tree maybe-file)
                , maybe-line
              , nil

          if (some? maybe-expression)
            comp-editor (:file store)
              , focus maybe-expression
              :vocabulary store
            comp-finder (:files store)
              , focus
              :file store

        comp-join

def comp-container $ create-comp :container render
