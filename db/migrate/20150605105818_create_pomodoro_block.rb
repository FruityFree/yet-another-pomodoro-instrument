class CreatePomodoroBlock < ActiveRecord::Migration
  def change
    create_table :pomodoro_blocks do |t|
      t.timestamps
    end
  end
end
