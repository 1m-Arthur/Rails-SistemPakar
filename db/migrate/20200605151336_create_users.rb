class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :user_id
      t.string :display_name
      t.string :line_id, :null => true
      t.string :hasil, :null => true
      t.string :number_stage
      t.timestamps
    end
  end
end
