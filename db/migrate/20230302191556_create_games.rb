class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.integer :year, null: false
      t.json :couples
      t.json :left

      t.timestamps
    end
  end
end
