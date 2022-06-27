class CreateSessions < ActiveRecord::Migration[6.1]
  def change
    create_table :sessions do |t|
      t.references :from, null: false, foreign_key: { to_table: :cad_systems }
      t.references :to, null: false, foreign_key: { to_table: :cad_systems }
      t.text :input_text
      t.text :result

      t.timestamps
    end
  end
end
