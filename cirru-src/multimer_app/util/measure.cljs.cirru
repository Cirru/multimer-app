
ns multimer-app.util.measure

defonce canvas-element $ .createElement js/document |canvas

defn text-width (content family size)
  let
    (ctx $ .getContext canvas-element |2d)
    set! (.-font ctx)
      str size "|px " family
    .-width $ .measureText ctx content
