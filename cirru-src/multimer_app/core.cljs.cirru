
ns multimer-app.core $ :require
  [] cljs.reader :as reader
  [] differ.core :as differ
  [] respo-spa.core :refer $ [] render
  [] multimer-app.updater.core :refer $ [] updater
  [] multimer-app.component.container :refer $ [] comp-container

defonce store-ref $ atom nil

defonce states-ref $ atom ({})

defonce ws $ new js/WebSocket |ws://localhost:7100

defn dispatch (target op op-data)
  let
    (new-store $ updater @store-ref op op-data)
    reset! store-ref new-store

defn render-app ()
  let
    (target $ .querySelector js/document |#app)
    render (comp-container @store-ref)
      , target dispatch states-ref

defn handle-message (event)
  let
    (message $ reader/read-string (.-data event))

    reset! store-ref $ differ/patch @store-ref message

defn -main ()
  enable-console-print!
  render-app
  add-watch store-ref :rerender render-app
  add-watch states-ref :rerender render-app
  set! (.-onmessage ws)
    , handle-message

set! (.-onload js/window)
  , -main

defn on-jsload ()
  render-app
  set! (.-onmessage ws)
    , handle-message
  .log js/console "|code updated."
