class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.timestamp :created_at
      t.integer :status
      t.references :notification, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true
    end
  end
end
