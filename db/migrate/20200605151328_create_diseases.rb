class CreateDiseases < ActiveRecord::Migration[6.0]
  def change
    create_table :diseases do |t|
      t.string :code_penyakit
      t.string :nama_penyakit
    end
  end
end
