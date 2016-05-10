
ns multimer-app.style.widget $ :require
  [] hsl.core :refer $ [] hsl

def button $ {} (:line-height 2.4)
  :font-size |14px
  :font-family |Menlo,Consolas
  :padding "|0 12px"
  :margin |4px
  :background-color $ hsl 200 90 40
  :color $ hsl 0 0 100
  :border |none
