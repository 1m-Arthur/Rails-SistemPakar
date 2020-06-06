class CreateKesimpulans < ActiveRecord::Migration[6.0]
  def change
    create_table :kesimpulans do |t|
      t.string :stage
      t.string :code_penyakit
    end
  end
end
