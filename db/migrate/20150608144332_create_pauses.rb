class CreatePauses < ActiveRecord::Migration
  def change
    create_table :pauses do |t|
      t.datetime :start_at
      t.datetime :end_at
      t.integer :segment_id
    end
  end
end
