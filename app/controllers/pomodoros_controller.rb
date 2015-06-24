class PomodorosController < ApplicationController
  def index
    if PomodoroBlock.any?
      pb = PomodoroBlock.active_pomodoro
      @restore_data = pb.restore_data
      @sequence = pb.sequence
      @all_time_hours = Segment.all_time_hours
      @last_7_days_hours = Segment.last_7_days_hours
      @this_week_hours = Segment.this_week_hours
      @today_hours = Segment.today_hours
    end
  end

  def start
    pomodoro_block = PomodoroBlock.create
    pomodoro_block.start
    @sequence = pomodoro_block.sequence
    # @sequence = PomodoroBlock.sequence
  end

  def pause
    PomodoroBlock.active_pomodoro.pause
  end

  def resume
    PomodoroBlock.active_pomodoro.resume
  end

  def cancel
    PomodoroBlock.active_pomodoro.cancel
    @sequence = PomodoroBlock.active_pomodoro.sequence
  end
end
