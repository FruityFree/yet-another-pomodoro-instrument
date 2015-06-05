class PomodoroBlock < ActiveRecord::Base
  has_many :segments
  after_create :attach_segments

  def sequence
    segments
    # [Segment.pomodoro, Segment.break]*3 + [Segment.pomodoro, Segment.long_break]
  end

  def attach_segments
    [Segment.pomodoro, Segment.break]*3 + [Segment.pomodoro, Segment.long_break]
  end
end
