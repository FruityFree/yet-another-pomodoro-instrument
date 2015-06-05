class PomodoroBlock < ActiveRecord::Base
  has_many :segments
  after_create :attach_segments

  def sequence
    segments
  end

  def start
    segments.first.start
  end

  def recount_segments
    if !segments.first.start_at
      raise "pomodoro block hasn't started"
    else
      
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
