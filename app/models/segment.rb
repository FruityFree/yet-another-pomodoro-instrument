class Segment < ActiveRecord::Base
  belongs_to :pomodoro_block

  def self.pomodoro(pomodoro_block_id=nil)
    create( type_name: "Pomodoro",
            duration: 1500,
            pomodoro_block_id: pomodoro_block_id)
  end

  def self.short_break(pomodoro_block_id=nil)
    create( type_name: "Break",
            duration: 300,
            pomodoro_block_id: pomodoro_block_id)
  end

  def self.long_break(pomodoro_block_id=nil)
    create( type_name: "Long Break",
            duration: 900,
            pomodoro_block_id: pomodoro_block_id)
  end

  def start
    update_attributes(start_at: DateTime.now)
  end

  def count_end
    update_attributes(end_at: start_at + duration.minutes)
  end

end
