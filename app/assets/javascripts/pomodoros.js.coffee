root = exports ? this

root.start_pomodoro = (element) ->
  element.show()

  root.timer_element = element
  root.seconds_left = 600

  update_timer()

  root.interval = setInterval(countdown, "1000")

countdown = ->
  root.seconds_left -= 1
  update_timer()

update_timer = ->
  root.timer_element.html(seconds_to_minuts(root.seconds_left))

seconds_to_minuts = (seconds) ->
  sec = seconds % 60
  min = (seconds-sec)/60
  sec = "0#{sec}" if sec.toString().length==1
  min = "0#{min}" if min.toString().length==1
  "#{min}:#{sec}"

root.pause_pomodoro = ->
  console.log "hello2"
  return
