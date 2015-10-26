class Segment < ActiveRecord::Base
  belongs_to :pomodoro_block

  POMODORO_DURATION   = 3000
  BREAK_DURATION      = 600
  LONG_BREAK_DURATION = 1200

  #FOR TEST
  # POMODORO_DURATION   = 5
  # BREAK_DURATION      = 3
  # LONG_BREAK_DURATION = 4

  has_many :pauses

  scope :pomodoros, -> {where(type_name: "Pomodoro")}
  scope :finished, -> {where.not(end_at:nil)}
  scope :last_7_days, -> {where('start_at > ?', 7.days.ago)}
  scope :this_week, -> {where('start_at > ?', Date.today.beginning_of_week)}
  scope :today, -> {where('start_at > ?', Date.today)}

  def self.pomodoro(pomodoro_block_id=nil)
    create( type_name: "Pomodoro",
            duration: POMODORO_DURATION,
            pomodoro_block_id: pomodoro_block_id)
  end

  def self.short_break(pomodoro_block_id=nil)
    create( type_name: "Break",
            duration: BREAK_DURATION,
            pomodoro_block_id: pomodoro_block_id)
  end

  def self.long_break(pomodoro_block_id=nil)
    create( type_name: "Long Break",
            duration: LONG_BREAK_DURATION,
            pomodoro_block_id: pomodoro_block_id)
  end


  def self.all_time_hours
    (pomodoros.finished.sum(:duration)/3600.0).round(2)
  end

  def self.last_7_days_hours
    (pomodoros.finished.last_7_days.sum(:duration)/3600.0).round(2)
  end

  def self.this_week_hours
    (pomodoros.finished.this_week.sum(:duration)/3600.0).round(2)
  end

  def self.today_hours
    (pomodoros.finished.today.sum(:duration)/3600.0).round(2)
  end


  def start
    update_attributes(start_at: DateTime.now)
  end

  def pause
    Pause.create(segment_id:id)
  end

  def paused?
    !pauses.empty? && pauses.last.end_at.nil?
  end

  def full_duration
    duration + pauses.inject(0){|sum,pause| sum+pause.duration}
  end

  def resume
    last_pause = pauses.last
    if last_pause.nil?
      raise "haven't paused yet"
    elsif !last_pause.end_at.nil?
      raise "already resumed"
    else
      last_pause.resume
    end
  end

  def count_end
    update_attributes(end_at: start_at + duration.minutes)
  end
end
