
ns multimer-app.util.event

def click-event $ if (js/window.hasOwnProperty |ontouchstart)

  , :touchstart :mousedown
