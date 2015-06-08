class PomodorosController < ApplicationController
  def index
    if PomodoroBlock.any?
      pb = PomodoroBlock.last
      @restore_data = pb.restore_data
      @sequence = pb.sequence
    end
  end

  def start
    pomodoro_block = PomodoroBlock.create
    pomodoro_block.start
    @sequence = pomodoro_block.sequence
    # @sequence = PomodoroBlock.sequence
  end

  def pause
  end

  def resume
  end
end
