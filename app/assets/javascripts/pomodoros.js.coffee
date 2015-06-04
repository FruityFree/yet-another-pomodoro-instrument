root = exports ? this
ready = ->
  root.timer_element = $("#timer")
  root.sequence_table = $("#sequence-table tbody")
  root.sequence = [{name: "pomodoro", duration: 5},{name: "pause", duration: 5},{name: "pomodoro", duration: 5}]

  root.reinitialize_pomodoro = ->
    return

  root.start_pomodoro = (sequence) ->
    root.sequence = sequence
    root.current_segment = 0

    clear_sequence_table()
    draw_sequence_table()

    root.seconds_left = 3
    update_timer()

    root.interval = setInterval(countdown, "1000")

  root.pause_pomodoro = ->
    clearInterval(root.interval)

  root.resume_pomodoro = ->
    root.interval = setInterval(countdown, "1000")

  draw_sequence_table = ->
    for segment in root.sequence
      row = "<tr>"
      row += "<td>#{segment.name}</td>"
      row += "<td>#{segment.duration} min</td>"
      row += "</tr>"
      $(row).appendTo(root.sequence_table)
  clear_sequence_table = ->
    tr.remove() for tr in root.sequence_table.children("tr")[1..-1]
  draw_sequence_table()


  countdown = ->
    root.seconds_left -= 1
    if root.seconds_left <= 0
      root.current_segment += 1
      if root.current_segment == root.sequence.length
        clearInterval(root.interval)
        pomodoro_finished()
      else
        root.seconds_left = root.sequence[root.current_segment].duration
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

$(document).ready(ready)
$(document).on('page:load', ready)
