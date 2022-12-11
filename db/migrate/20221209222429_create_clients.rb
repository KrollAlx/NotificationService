class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string :phone_number
      t.string :operator_code
      t.string :tag
      t.string :timezone
    end
  end
end
