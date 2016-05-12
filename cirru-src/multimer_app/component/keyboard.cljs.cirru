
ns multimer-app.component.keyboard $ :require
  [] respo.alias :refer $ [] create-comp div span button
  [] multimer-app.style.widget :as widget
  [] clojure.string :refer $ [] upper-case
  [] multimer-app.util.event :refer $ [] click-event

defn init-state ()
  {} :punctuation? false :shift? false

defn update-state (state op)
  case op
    :punctuation? $ update state :punctuation? not
    :shift? $ update state :shift? not
    , state

defn handle-at (text route)
  fn (e dispatch)
    route text dispatch

defn handle-special (text mutate)
  fn (e dispatch)
    case text
      |switch $ mutate :punctuation?
      |shift $ mutate :shift?
      , nil

def style-board $ {} (:display |flex)
  :flex 1

def style-line $ {} (:display |flex)

def style-sudoku $ {} (:flex 1)

defn render-button (text handler)
  button $ {} :style
    merge widget/keystroke $ {} (:font-size |18px)
    , :event
    {} click-event handler
    , :attrs
    {} :inner-text text

defn render-letter-1 (route shift?)
  let
    (f $ if shift? upper-case identity)
    div ({} :style style-sudoku)
      div ({} :style style-line)
        render-button (f |v)
          handle-at (f |v)
            , route

        render-button (f |h)
          handle-at (f |h)
            , route

        render-button (f |g)
          handle-at (f |g)
            , route

      div ({} :style style-line)
        render-button (f |x)
          handle-at (f |x)
            , route

        render-button (f |b)
          handle-at (f |b)
            , route

        render-button (f |y)
          handle-at (f |y)
            , route

      div ({} :style style-line)
        render-button (f |q)
          handle-at (f |q)
            , route

        render-button (f |w)
          handle-at (f |w)
            , route

        render-button (f |k)
          handle-at (f |k)
            , route

defn render-letter-2 (route shift?)
  let
    (f $ if shift? upper-case identity)
    div ({} :style style-sudoku)
      div ({} :style style-line)
        render-button (f |r)
          handle-at (f |r)
            , route

        render-button (f |t)
          handle-at (f |t)
            , route

        render-button (f |e)
          handle-at (f |e)
            , route

      div ({} :style style-line)
        render-button (f |l)
          handle-at (f |l)
            , route

        render-button (f |i)
          handle-at (f |i)
            , route

        render-button (f |n)
          handle-at (f |n)
            , route

      div ({} :style style-line)
        render-button (f |p)
          handle-at (f |p)
            , route

        render-button (f |d)
          handle-at (f |d)
            , route

        render-button (f |c)
          handle-at (f |c)
            , route

defn render-letter-3 (route shift?)
  let
    (f $ if shift? upper-case identity)
    div ({} :style style-sudoku)
      div ({} :style style-line)
        render-button (f |a)
          handle-at (f |a)
            , route

        render-button (f |s)
          handle-at (f |s)
            , route

        render-button (f |o)
          handle-at (f |o)
            , route

      div ({} :style style-line)
        render-button (f |u)
          handle-at (f |u)
            , route

        render-button (f |m)
          handle-at (f |m)
            , route

        render-button (f |f)
          handle-at (f |f)
            , route

      div ({} :style style-line)
        render-button (f |j)
          handle-at (f |j)
            , route

        render-button (f |z)
          handle-at (f |z)
            , route

        render-button |. $ handle-at |. route

defn render-control (route mutate)
  div ({} :style style-sudoku)
    div ({} :style style-line)
      render-button |: $ handle-at |: route
      render-button |␣ $ handle-at |space route
      render-button |⌫ $ handle-at |cancel route
    div ({} :style style-line)
      render-button |- $ handle-at |v route
      render-button |/ $ handle-at |w route
      render-button "| ⏎" $ handle-at |enter route
    div ({} :style style-line)
      render-button || $ handle-at || route
      render-button |⋯ $ handle-special |switch mutate
      render-button |⇧ $ handle-special |shift mutate

defn render-control-2 (route mutate)
  div ({} :style style-sudoku)
    div ({} :style style-line)
      render-button |+ $ handle-at |: route
      render-button |* $ handle-at || route
      render-button |⌫ $ handle-at |cancel route
    div ({} :style style-line)
      render-button |= $ handle-at |= route
      render-button |% $ handle-at |% route
      render-button "| ⏎" $ handle-at |enter route
    div ({} :style style-line)
      render-button |0 $ handle-at |0 route
      render-button |⋯ $ handle-special |switch mutate
      render-button |⇧ $ handle-special |shift mutate

defn render-brackets (route)
  div ({} :style style-sudoku)
    div ({} :style style-line)
      render-button "|(" $ handle-at "|(" route
      render-button "|)" $ handle-at "|)" route
      render-button |, $ handle-at |, route
    div ({} :style style-line)
      render-button |[ $ handle-at |[ route
      render-button |] $ handle-at |] route
      render-button |# $ handle-at |. route
    div ({} :style style-line)
      render-button |{ $ handle-at |{ route
      render-button |} $ handle-at |} route
      render-button |? $ handle-at |? route

defn render-symbols (route)
  div ({} :style style-sudoku)
    div ({} :style style-line)
      render-button |@ $ handle-at |@ route
      render-button |$ $ handle-at |$ route
      render-button |_ $ handle-at |_ route
    div ({} :style style-line)
      render-button |~ $ handle-at |~ route
      render-button |` $ handle-at |` route
      render-button |' $ handle-at |' route
    div ({} :style style-line)
      render-button |& $ handle-at |& route
      render-button |^ $ handle-at |^ route
      render-button |; $ handle-at | route

defn render-numbers (route)
  div ({} :style style-sudoku)
    div ({} :style style-line)
      render-button |1 $ handle-at |1 route
      render-button |2 $ handle-at |2 route
      render-button |3 $ handle-at |3 route
    div ({} :style style-line)
      render-button |4 $ handle-at |4 route
      render-button |5 $ handle-at |5 route
      render-button |6 $ handle-at |6 route
    div ({} :style style-line)
      render-button |7 $ handle-at |7 route
      render-button |8 $ handle-at |8 route
      render-button |9 $ handle-at |9 route

defn render-punctuation (route mutate)
  div ({} :style style-board)
    render-symbols route
    render-brackets route
    render-numbers route
    render-control-2 route mutate

defn render-alphabet (route mutate shift?)
  div ({} :style style-board)
    render-letter-1 route shift?
    render-letter-2 route shift?
    render-letter-3 route shift?
    render-control route mutate

defn render (route)
  fn (state mutate)
    div ({})
      if (:punctuation? state)
        render-punctuation route mutate
        render-alphabet route mutate $ :shift? state

def comp-keyboard $ create-comp :keyboard init-state update-state render
