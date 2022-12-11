class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.timestamp :start_at
      t.string :text
      t.string :filter
      t.timestamp :end_at
    end
  end
end
