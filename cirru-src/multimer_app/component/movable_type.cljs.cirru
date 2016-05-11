
ns multimer-app.component.movable-type $ :require
  [] hsl.core :refer $ [] hsl
  [] respo.alias :refer $ [] create-comp div span input pre button
  [] multimer-app.util.element :refer $ [] text
  [] multimer-app.style.widget :as widget
  [] clojure.string :as string

def leading-chars |abcdefghijklmnopqrstuvwxyz:|.@

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
      and
        = 13 $ :key-code simple-event
        not= draft |
      do (mutate :draft |)
        mutate :add draft

defn handle-remove (word mutate)
  fn (simple-event dispatch)
    mutate :rm word

defn handle-toggle (mutate)
  fn (simple-event dispatch)
    mutate :toggle

defn render (dictionary focus)
  fn (state mutate)
    let
      (display-dict $ if (:editable? state) (:candidates state) (into (hash-set) (concat dictionary $ :candidates state)))
        grouped-dict $ ->> display-dict
          group-by $ fn (word)
            let
              (first-letter $ get word 0)
              if (string/includes? leading-chars first-letter)
                , first-letter |0

      println grouped-dict
      div ({})
        div
          {} :style $ {} (:margin "|16px 4px")
            :max-height |400px
            :overflow |auto
          ->> grouped-dict (sort)
            map $ fn (entry)
              [] (key entry)
                div ({})
                  ->> (val entry)
                    map $ fn (word)
                      [] word $ pre
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

            into $ sorted-map

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
            {} :click $ handle-toggle mutate
            , :attrs
            {} :inner-text |edit?

def comp-movable-type $ create-comp :movable-type init-state update-state render
