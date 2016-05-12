
ns multimer-app.component.movable-type $ :require
  [] hsl.core :refer $ [] hsl
  [] respo.alias :refer $ [] create-comp div span input pre button
  [] multimer-app.util.element :refer $ [] text
  [] multimer-app.style.widget :as widget
  [] clojure.string :as string
  [] respo.component.debug :refer $ [] comp-debug
  [] multimer-app.component.keyboard :refer $ [] comp-keyboard
  [] multimer-app.component.operations :refer $ [] comp-operations

def leading-chars |abcdefghijklmnopqrstuvwxyz:|.@

defn init-state ()
  {} :draft | :editable? false :show? true

defn update-state (state op op-data)
  case op
    :draft $ assoc state :draft op-data
    :toggle $ update state :editable? not
    :show $ update state :show? not
    :cancel $ update state :draft
      fn (draft)
        if (not= draft |)
          subs draft 0 $ dec (count draft)
          , |

    , state

defn handle-local-click
  word focus mutate editable?
  fn (simple-event dispatch)
    if editable? (dispatch :vocabulary/rm-word word)
      do
        dispatch :edit/update-token $ conj focus word
        mutate :draft |

defn handle-change (mutate focus)
  fn (simple-event dispatch)
    mutate :draft $ :value simple-event
    dispatch :edit/update-token $ conj focus (:value simple-event)

defn handle-keydown (draft mutate focus)
  fn (simple-event dispatch)
    if
      and
        = 13 $ :key-code simple-event
        not= draft |
      do $ dispatch :vocabulary/add-word draft

defn handle-remove (word mutate)
  fn (simple-event dispatch)
    dispatch :vocabulary/rm-word word

defn handle-toggle (mutate)
  fn (simple-event dispatch)
    mutate :toggle

defn handle-show (mutate)
  fn (simple-event dispatch)
    mutate :show

defn handle-keyboard (mutate draft focus)
  fn (data dispatch)
    cond
      (= (count data) (, 1))
        let
          (new-draft $ str draft data)
          mutate :draft new-draft
          dispatch :edit/update-token $ conj focus new-draft

      (= data |cancel)
        let
          (new-draft $ if (= draft |) (, draft) (subs draft 0 $ dec (count draft)))

          mutate :draft new-draft
          dispatch :edit/update-token $ conj focus new-draft

      (= data |space)
        let
          (new-draft $ str draft |)
          mutate :draft new-draft
          dispatch :edit/update-token $ conj focus new-draft

      (= data |enter) (dispatch :vocabulary/add-word draft)
      :else nil

defn render (dictionary focus vocabulary)
  fn (state mutate)
    let
      (display-dict $ if (:editable? state) (, vocabulary) (into (hash-set) (concat (filter (fn (x) (not= x |)) (, dictionary)) (, vocabulary))))

      div ({})
        div
          {} :style $ {} (:padding "|0 8px")
            :margin "|4px 0px 16px 0"
          input $ {} :event
            {} :input (handle-change mutate focus)
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
          button $ {} :style
            merge widget/button $ {}
            , :event
            {} :click $ handle-show mutate
            , :attrs
            {} :inner-text |show?

        div
          {} :style $ {} (:display |flex)
          div
            {} :style $ {} (:margin "|0px 4px")
              :max-height |400px
              :overflow |auto
              :flex 1
            if (:show? state)
              ->> display-dict
                filter $ fn (word)
                  if
                    = | $ :draft state
                    , true
                    if
                      = word $ :draft state
                      , false
                      string/starts-with? word $ :draft state

                take 10
                map $ fn (word)
                  [] word $ pre
                    {} :style
                      merge widget/button $ {}
                        :background-color $ if (:editable? state)
                          hsl 0 80 93
                          hsl 300 80 70
                        :color $ if (:editable? state)
                          hsl 0 90 40
                          hsl 0 0 100
                        :margin "|6px 6px"

                      , :attrs
                      {} :inner-text word
                      , :event
                      {} :click $ handle-local-click word focus mutate (:editable? state)

                into $ sorted-map

          div
            {} :style $ {} (:flex 1)
            comp-operations focus mutate

        div ({})
          comp-keyboard $ handle-keyboard mutate (:draft state)
            , focus

        -- comp-debug state $ {}

def comp-movable-type $ create-comp :movable-type init-state update-state render
