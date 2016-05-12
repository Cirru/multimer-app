
ns multimer-app.component.join $ :require
  [] respo.alias :refer $ [] create-comp span div input button
  [] multimer-app.util.element :refer $ [] text
  [] respo.component.debug :refer $ [] comp-debug
  [] multimer-app.style.widget :as widget

defn init-state ()
  {} :name |chen :password |

defn update-state (state target x)
  assoc state target x

defn handle-change (mutate target)
  fn (simple-event dispatch)
    mutate target $ :value simple-event

defn handle-submit (state)
  fn (simple-event dispatch)
    dispatch :user/join $ [] (:name state)
      :password state

defn render ()
  fn (state mutate)
    div
      {} :style $ {} (:display |flex)
        :flex-direction |column
        :justify-content |center
        :align-items |center
        :height |100%
      div
        {} :style $ {} (:width |240px)
        -- comp-debug state $ {}
        div ({})
          div ({})
            text |Name
          input $ {} :style (merge widget/textbox)
            , :attrs
            {} :value (:name state)
              , :placeholder |Name
            , :event
            {} :input $ handle-change mutate :name

        div ({})
          div ({})
            text |Password
          input $ {} :style (merge widget/textbox)
            , :attrs
            {} :value (:password state)
              , :placeholder |Password
            , :event
            {} :input $ handle-change mutate :password

        div ({})
          button $ {} :style (merge widget/button)
            , :attrs
            {} :inner-text |Submit
            , :event
            {} :click $ handle-submit state

def comp-join $ create-comp :join init-state update-state render
