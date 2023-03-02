class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.integer :year
      t.string :couples
      t.string :left

      t.timestamps
    end
  end
end
