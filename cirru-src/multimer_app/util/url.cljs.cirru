
ns multimer-app.util.url $ :require
  [] clojure.string :as string

defn parse-query ()
  let
    (search-query js/location.search)
      is-query? $ and
        > (count search-query)
          , 1
        string/starts-with? search-query |?

    if is-query? $ let
      (pieces $ js->clj (.split (subs search-query 1) (, |&)))

      into ({})
        map
          fn (chunk)
            js->clj $ .split chunk |=
          , pieces
