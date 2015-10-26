class PomodoroBlock < ActiveRecord::Base
  has_many :segments, -> { order(:id)}
  before_create :cancel_previous
  after_create :attach_segments


  def self.active_pomodoro
    last
  end

  def sequence
    segments
  end

  def start
    segments.first.start
  end

  def pause
    current_segment.pause
  end

  def resume
    current_segment.resume
  end

  def cancel
    recount_segments
    segments.select{|s| s.end_at.nil?}.each{|s| s.destroy}
    destroy if segments.count.zero?
  end

  def restore_data
    recount_segments

    return if !segments.first.start_at

    current_segment_index = segments.select{|s| s.start_at}.count - 1
    current_segment = segments[current_segment_index]

    seconds_pass = DateTime.now.to_i - current_segment.start_at.to_i
    time_left = current_segment.full_duration - seconds_pass
    time_left = 0 if time_left < 0
    {
      current_segment: current_segment_index,
      time_left: time_left,
      paused: current_segment.paused?
    }
  end

  def recount_segments
    return if !segments.first.start_at

    now = DateTime.now
    segments.each_with_index do |segment, i|
      p segment
      expected_end = segment.start_at + segment.full_duration.seconds
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

  def current_segment
    segments.select{|s| s.start_at}.try(:first)
  end

  private

  def cancel_previous
    PomodoroBlock.active_pomodoro.try(:cancel)
  end

  def attach_segments
    [ pomodoro,
      short_break,
      pomodoro,
      short_break,
      pomodoro,
      short_break,
      pomodoro,
      long_break]
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
