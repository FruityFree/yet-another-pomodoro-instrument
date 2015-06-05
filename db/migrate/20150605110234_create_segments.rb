class CreateSegments < ActiveRecord::Migration
  def change
    create_table :segments do |t|
      t.integer :pomodoro_block_id
      t.string :type_name
      t.integer :duration
      t.datetime :start_at
      t.datetime :end_at
    end
  end
end
