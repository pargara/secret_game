class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.references :area, null: false, foreign_key: true
      t.string :name
      t.integer :year_game

      t.timestamps
    end
  end
end
