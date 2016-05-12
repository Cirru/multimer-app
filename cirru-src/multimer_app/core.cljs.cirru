
ns multimer-app.core $ :require
  [] cljs.reader :as reader
  [] differ.core :as differ
  [] respo-spa.core :refer $ [] render
  [] multimer-app.updater.core :refer $ [] updater
  [] multimer-app.component.container :refer $ [] comp-container
  [] multimer-app.util.url :refer $ [] parse-query

defonce store-ref $ atom nil

defonce states-ref $ atom ({})

defonce ws $ let
  (query $ parse-query)
  enable-console-print!
  println query
  new js/WebSocket $ str |ws://
    or (get query |domain)
      , js/location.hostname
    , |:
    or (get query |port)
      , 7100

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
    println |patched.

defn handle-reload (event)
  println "|reloading in 4s..."
  js/setTimeout
    fn ()
      .reload js/location
    , 4000

defn -main ()
  enable-console-print!
  render-app
  add-watch store-ref :rerender render-app
  add-watch states-ref :rerender render-app
  set! (.-onmessage ws)
    , handle-message
  set! (.-onclose ws)
    , handle-reload

set! (.-onload js/window)
  , -main

defn on-jsload ()
  render-app
  set! (.-onmessage ws)
    , handle-message
  .log js/console "|code updated."
