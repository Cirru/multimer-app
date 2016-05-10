
ns multimer-app.core $ :require
  [] cljs.reader :as reader
  [] differ.core :as differ
  [] respo-spa.core :refer $ [] render
  [] multimer-app.updater.core :refer $ [] updater
  [] multimer-app.component.container :refer $ [] comp-container

defonce store-ref $ atom nil

defonce states-ref $ atom ({})

defonce ws $ new js/WebSocket |ws://repo:7100

defn dispatch (op op-data)
  .send ws $ pr-str ([] op op-data)

defn render-app ()
  let
    (target $ .querySelector js/document |#app)
    render (comp-container @store-ref)
      , target dispatch states-ref

defn handle-message (event)
  let
    (message $ reader/read-string (.-data event)) (old-store @store-ref)

    reset! store-ref $ differ/patch @store-ref message
    let
      (cursor $ .querySelector js/document |.cursor)
      if (some? cursor)
        do $ .focus cursor

    println |patched.

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
