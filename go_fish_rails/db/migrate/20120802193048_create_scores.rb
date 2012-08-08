class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :value
      t.integer :player_index
      t.integer :game_result_id

      t.timestamps
    end
  end
end
