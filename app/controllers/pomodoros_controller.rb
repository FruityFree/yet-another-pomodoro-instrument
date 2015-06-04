class PomodorosController < ApplicationController
  def index
  end

  def start
    @sequence = Pomodoro::SEQUENCE
  end

  def pause
  end
end
