class PomodorosController < ApplicationController
  def index
  end

  def start
    @sequence = Pomodoro::SEQUENCE
  end

  def pause
  end

  def resume
  end
end
