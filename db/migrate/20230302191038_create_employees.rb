class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.references :area, null: false, foreign_key: true
      t.string :name, null: false
      t.integer :year_game, null: false

      t.timestamps
    end
  end
end
