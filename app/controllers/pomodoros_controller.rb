class PomodorosController < ApplicationController
  def index
  end

  def start
    @sequence = Pomodoro.sequence
  end

  def pause
  end

  def resume
  end
end
