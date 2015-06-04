root = exports ? this

root.reinitialize_pomodoro = ->
  return

root.start_pomodoro = (element) ->
  root.sequence = [1,2,1,2,1,4]

  root.timer_element = element
  root.seconds_left = 3
  root.current_segment = 0
  update_timer()

  root.interval = setInterval(countdown, "1000")

countdown = ->
  root.seconds_left -= 1
  if root.seconds_left <= 0
    root.current_segment += 1
    if root.current_segment == root.sequence.length
      clearInterval(root.interval)
      pomodoro_finished()
    else
      root.seconds_left = root.sequence[root.current_segment]
      update_timer()
  else
    update_timer()

update_timer = ->
  root.timer_element.html(seconds_to_minuts(root.seconds_left))

pomodoro_finished = ->
  root.timer_element.html("Pomodoro finished!")

seconds_to_minuts = (seconds) ->
  sec = seconds % 60
  min = (seconds-sec)/60
  sec = "0#{sec}" if sec.toString().length==1
  min = "0#{min}" if min.toString().length==1
  "#{min}:#{sec}"

root.pause_pomodoro = ->
  console.log "hello2"
  return
