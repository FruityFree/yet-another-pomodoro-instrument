class PomodoroBlock < ActiveRecord::Base
  has_many :segments
  after_create :attach_segments

  def sequence
    segments
  end

  def start
    segments.first.start
  end

  private

  def attach_segments
    segments = [
      Segment.pomodoro,
      Segment.break,
      Segment.pomodoro,
      Segment.break,
      Segment.pomodoro,
      Segment.break,
      Segment.pomodoro,
      Segment.long_break,
    ]
    segments.each{|s| s.update_attributes(pomodoro_block_id:id)}
  end
end
