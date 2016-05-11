
ns multimer-app.style.widget $ :require
  [] hsl.core :refer $ [] hsl

def button $ {} (:line-height 2)
  :font-size |14px
  :font-family |Menlo,Consolas
  :padding "|0 12px"
  :margin |4px
  :background-color $ hsl 200 90 40
  :color $ hsl 0 0 100
  :border |none
  :display |inline-block
  :outline |none
  :min-width |16px
  :min-height |16px
  :white-space |nowrap

def keystroke $ {} (:line-height 2)
  :font-size |16px
  :font-family |Menlo,Consolas
  :padding "|0 12px"
  :margin |4px
  :background-color $ hsl 200 90 40
  :color $ hsl 0 0 100
  :border |none
  :display |inline-block
  :outline |none
  :min-width |40px
  :min-height |40px
  :flex 1
