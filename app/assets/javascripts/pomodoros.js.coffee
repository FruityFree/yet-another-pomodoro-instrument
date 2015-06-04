root = exports ? this

root.start_pomodoro = (element) ->
  element.show()

  root.timer_element = element
  root.seconds_left = 60

  element.html(root.seconds_left)

  root.interval = setInterval(countdown, "1000")

countdown = ->
  root.seconds_left -= 1
  root.timer_element.html(root.seconds_left)

root.pause_pomodoro = ->
  console.log "hello2"
  return
