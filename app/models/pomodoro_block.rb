class PomodoroBlock < ActiveRecord::Base
  has_many :segments
  after_create :attach_segments

  def sequence
    segments
  end

  def start
    segments.first.start
  end

  def restore_data
    recount_segments
    raise "pomodoro block hasn't started" if !segments.first.start_at
    current_segment_index = segments.select{|s| s.start_at}.count - 1
    current_segment = segments[current_segment_index]

    seconds_pass = DateTime.now.to_i - current_segment.start_at.to_i
    time_left = current_segment.duration - seconds_pass
    time_left = 0 if time_left < 0
    {current_segment: current_segment_index, time_left: time_left}
  end

  def recount_segments
    if !segments.first.start_at
      raise "pomodoro block hasn't started"
    else
      now = DateTime.now
      segments.each_with_index do |segment, i|
        expected_end = segment.start_at + segment.duration.seconds
        if expected_end > now
          break
        else
          segment.update_attributes(end_at: expected_end)
          if segments[i+1]
            segments[i+1].update_attributes(start_at: expected_end)
          end
        end
      end
    end
  end

  private

  def attach_segments
    segments = [
      pomodoro,
      short_break,
      pomodoro,
      short_break,
      pomodoro,
      short_break,
      pomodoro,
      long_break,
    ]
  end

  def pomodoro
    Segment.pomodoro(id)
  end

  def short_break
    Segment.short_break(id)
  end

  def long_break
    Segment.long_break(id)
  end
end
