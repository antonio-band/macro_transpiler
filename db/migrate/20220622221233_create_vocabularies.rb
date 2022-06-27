class CreateVocabularies < ActiveRecord::Migration[6.1]
  def change
    create_table :vocabularies do |t|
      t.references :cad_system, null: false, foreign_key: { to_table: :cad_systems }
      t.json :body

      t.timestamps
    end
  end
end
