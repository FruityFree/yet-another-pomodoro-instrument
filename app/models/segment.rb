class Segment < ActiveRecord::Base
  belongs_to :pomodoro_block

  POMODORO_DURATION   = 1500
  BREAK_DURATION      = 300
  LONG_BREAK_DURATION = 900

  #FOR TEST
  # POMODORO_DURATION   = 5
  # BREAK_DURATION      = 3
  # LONG_BREAK_DURATION = 4

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

  def count_end
    update_attributes(end_at: start_at + duration.minutes)
  end
end
