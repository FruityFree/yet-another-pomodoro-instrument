class Pomodoro < ActiveRecord::Base
  def self.sequence
    [{name: "Pomodoro", duration: 2},
    {name: "Pause", duration: 5},
    {name: "Pomodoro", duration: 2},
    {name: "Pause", duration: 5},
    {name: "Pomodoro", duration: 2},
    {name: "Pause", duration: 5},
    {name: "Pomodoro", duration: 2},
    {name: "Pause", duration: 5}]
  end
end
