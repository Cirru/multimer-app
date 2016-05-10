
ns multimer-app.component.movable-type $ :require
  [] hsl.core :refer $ [] hsl
  [] respo.alias :refer $ [] create-comp div span input pre button
  [] multimer-app.util.element :refer $ [] text
  [] multimer-app.style.widget :as widget

defn init-state ()
  {} :draft | :candidates (hash-set)
    , :editable? false

defn update-state (state op op-data)
  case op
    :draft $ assoc state :draft op-data
    :add $ update state :candidates
      fn (candidates)
        conj candidates op-data

    :rm $ update state :candidates
      fn (candidates)
        into (hash-set)
          filter
            fn (x)
              not= x op-data
            , candidates

    :toggle $ update state :editable? not
    , state

defn handle-select (word focus)
  fn (simple-event dispatch)
    dispatch :edit/update-token $ conj focus word

defn handle-local-click
  word focus mutate editable?
  fn (simple-event dispatch)
    if editable? (mutate :rm word)
      dispatch :edit/update-token $ conj focus word

defn handle-change (mutate)
  fn (simple-event dispatch)
    mutate :draft $ :value simple-event

defn handle-keydown (draft mutate focus)
  fn (simple-event dispatch)
    if
      = 13 $ :key-code simple-event
      do
        dispatch :edit/update-token $ conj focus draft
        mutate :draft |
        mutate :add draft

defn handle-remove (word mutate)
  fn (simple-event dispatch)
    mutate :rm word

defn handle-toggle (mutate)
  fn (simple-event dispatch)
    mutate :toggle

defn handle-once (mutate word focus)
  fn (e dispatch)
    dispatch :edit/update-token $ conj focus word
    mutate :draft |

defn handle-submit (mutate word focus)
  fn (e dispatch)
    dispatch :edit/update-token $ conj focus word
    mutate :draft |
    mutate :add word

defn render (dictionary focus)
  fn (state mutate)
    div ({})
      div
        {} :style $ {} (:padding "|0 8px")
          :margin "|16epx 0px"
        input $ {} :event
          {} :input (handle-change mutate)
            , :keydown
            handle-keydown (:draft state)
              , mutate focus

          , :style
          {} (:line-height 2)
            :font-size |14px
            :font-family |Menlo,Consolas
            :padding "|0 8px"
          , :attrs
          {} :value $ :draft state

        div $ {} :style
          {} (:width |8px)
            :display |inline-block

        button $ {} :style
          merge widget/button $ {}
          , :event
          {} :click $ handle-submit mutate (:draft state)
            , focus
          , :attrs
          {} :inner-text |submit

        button $ {} :style
          merge widget/button $ {}
          , :event
          {} :click $ handle-once mutate (:draft state)
            , focus
          , :attrs
          {} :inner-text |once

        button $ {} :style
          merge widget/button $ {}
          , :event
          {} :click $ handle-toggle mutate
          , :attrs
          {} :inner-text |edit?

      div
        {} :style $ {} (:margin "|8px 0")
        ->> dictionary (sort)
          map-indexed $ fn (index word)
            [] index $ span
              {} :event
                {} :click $ handle-select word focus
                , :attrs
                {} :inner-text word
                , :style
                {} (:font-size |14px)
                  :font-family |Menlo,Consolas
                  :line-height 1.8
                  :background-color $ hsl 120 70 60
                  :display |inline-block
                  :padding "|0 8px"
                  :min-width |40px
                  :min-height |20px
                  :vertical-align |middle
                  :color $ hsl 0 0 100
                  :margin "|4px 4px"

          into $ sorted-map

      div
        {} :style $ {} (:margin "|16px 4px")
        ->> (:candidates state)
          sort
          map-indexed $ fn (index word)
            [] index $ pre
              {} :style
                {} (:font-family |Menlo,Consolas)
                  :font-size |14px
                  :background-color $ if (:editable? state)
                    hsl 0 80 93
                    hsl 300 80 70
                  :padding "|0 8px"
                  :line-height 2
                  :color $ if (:editable? state)
                    hsl 0 90 40
                    hsl 0 0 100
                  :display |inline-block
                  :margin "|4px 6px"

                , :attrs
                {} :inner-text word
                , :event
                {} :click $ handle-local-click word focus mutate (:editable? state)

          into $ sorted-map

def comp-movable-type $ create-comp :movable-type init-state update-state render
