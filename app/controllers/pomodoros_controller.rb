class PomodorosController < ApplicationController
  def index
  end

  def start
    pomodoro_block = PomodoroBlock.create
    @sequence = pomodoro_block.sequence
    # @sequence = PomodoroBlock.sequence
  end

  def pause
  end

  def resume
  end
end
