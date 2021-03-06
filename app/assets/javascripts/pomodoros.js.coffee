root = exports ? this

ready = ->
  root.audio = new Audio('ding.wav')
  root.timer_element = $("#timer")
  root.sequence_table = $("#sequence-table tbody")

  # root.sequence = [{name: "pomodoro", duration: 5},
  # {name: "pause", duration: 5},
  # {name: "pomodoro", duration: 5}]
  # sec_in_min = 1 #can vary for testing purpose

  root.reinitialize_pomodoro = (sequence, restore_data) ->
    root.sequence = sequence
    root.current_segment = restore_data.current_segment

    clear_sequence_table()
    draw_sequence_table(restore_data.current_segment)

    root.seconds_left = restore_data.time_left
    update_timer()

    root.interval = setInterval(countdown, "1000")
    root.pause_pomodoro() if restore_data.paused


  root.start_pomodoro = (sequence) ->
    root.sequence = sequence
    root.current_segment = 0

    clear_sequence_table()
    draw_sequence_table()

    root.seconds_left = root.sequence[0].duration
    update_timer()

    clearInterval(root.interval)
    root.interval = setInterval(countdown, "1000")

  root.pause_pomodoro = ->
    clearInterval(root.interval)
    $("#pause-button").hide()
    $("#resume-button").show()

  root.resume_pomodoro = ->
    root.interval = setInterval(countdown, "1000")
    $("#pause-button").show()
    $("#resume-button").hide()

  root.cancel_pomodoro = (sequence) ->
    clearInterval(root.interval)
    root.sequence = sequence
    clear_sequence_table()
    draw_sequence_table(-2)


  draw_sequence_table =(current_index=1) ->
    for segment in root.sequence
      console.log segment
      row = "<tr>"
      row += "<td>#{segment.type_name}</td>"
      row += "<td>#{segment.duration/60} min</td>"
      row += "<td>#{format_time(segment.start_at)}</td>"
      row += "<td>#{format_time(segment.end_at)}</td>"
      row += "</tr>"
      $(row).appendTo(root.sequence_table)
    root.sequence_table.children("tr").eq(current_segment+1).addClass("current")
    root.sequence_table.parent().show()
  clear_sequence_table = ->
    tr.remove() for tr in root.sequence_table.children("tr")[1..-1]

  format_time = (datetime)->
    if datetime
      dt = new Date(datetime)
      "#{dt.getHours()}:#{dt.getMinutes()}"
    else
      ""


  countdown = ->
    root.seconds_left -= 1
    if root.seconds_left <= 0
      audio.play()
      root.current_segment += 1
      if root.current_segment == root.sequence.length
        clearInterval(root.interval)
        pomodoro_finished()
      else
        root.seconds_left = root.sequence[root.current_segment].duration
        root.sequence_table.children("tr").eq(root.current_segment).removeClass("current")
        root.sequence_table.children("tr").eq(root.current_segment+1).addClass("current")
        update_timer()
    else
      update_timer()

  update_timer = ->
    time = seconds_to_minuts(root.seconds_left)
    document.title = "#{time}, #{root.sequence[root.current_segment].type_name}"
    root.timer_element.html(time)

  pomodoro_finished = ->
    root.timer_element.html("Pomodoro finished!")
    root.sequence_table.children("tr").last().removeClass("current")

  seconds_to_minuts = (seconds) ->
    sec = seconds % 60
    min = (seconds-sec)/60
    sec = "0#{sec}" if sec.toString().length==1
    min = "0#{min}" if min.toString().length==1
    "#{min}:#{sec}"

  $(window).keypress((e) ->
    if e.which == 32
      if $("#pause-button").is(":visible")
        $("#pause-button a").click()
      else
        $("#resume-button a").click()
  )


$(document).ready(ready)
$(document).on('page:load', ready)
