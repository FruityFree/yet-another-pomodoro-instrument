class Segment < ActiveRecord::Base
  belongs_to :pomodoro_block

  POMODORO_DURATION   = 1500
  BREAK_DURATION      = 300
  LONG_BREAK_DURATION = 900

  #FOR TEST
  # POMODORO_DURATION   = 5
  # BREAK_DURATION      = 3
  # LONG_BREAK_DURATION = 4

  has_many :pauses

  scope :pomodoros, -> {where(type_name: "Pomodoro")}
  scope :finished, -> {where.not(end_at:nil)}

  def self.count_duration
    @relation.inject(0){|sum,s| sum+s.duration}
  end

  def self.count_duration_in_minutes
    count_duration/60.0
  end

  def self.count_duration_in_hours
    count_duration/3600.0
  end

  # def self.finished
  #   all.select{|s| !s.end_at.nil?}
  # end




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
