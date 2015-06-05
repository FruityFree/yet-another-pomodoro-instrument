class Segment < ActiveRecord::Base
  belongs_to :pomodoro_block

  def self.pomodoro
    create(name: "Pomodoro", duration: 25)
  end

  def self.break
    create(name: "Break", duration: 5)
  end

  def self.long_break
    create(name: "Long Break", duration: 15)
  end

end
