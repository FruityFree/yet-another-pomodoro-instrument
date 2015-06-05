class Segment < ActiveRecord::Base
  belongs_to :pomodoro_block

  def self.pomodoro
    create(type_name: "Pomodoro", duration: 25)
  end

  def self.break
    create(type_name: "Break", duration: 5)
  end

  def self.long_break
    create(type_name: "Long Break", duration: 15)
  end

  def start
    update_attributes(start_at: DateTime.now)
  end

  def count_end
    update_attributes(end_at: start_at + duration.minutes)
  end

end
