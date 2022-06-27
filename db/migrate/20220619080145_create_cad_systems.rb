class CreateCadSystems < ActiveRecord::Migration[6.1]
  def change
    create_table :cad_systems do |t|
      t.string :name

      t.timestamps
    end
  end
end
