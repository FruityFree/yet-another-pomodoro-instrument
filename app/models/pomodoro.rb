class Pomodoro < ActiveRecord::Base
  SEQUENCE = {name: "Pomodoro"}

  # has_many :pauses

end

# ,
# {name: "Pause", duration: 5},
# {name: "Pomodoro", duration: "25"},
# {name: "Pause", duration: "5"},
# {name: "Pomodoro", duration: "25"},
# {name: "Pause", duration: "5"},
# {name: "Pomodoro", duration: "25"},
# {name: "Pause", duration: "15"}
