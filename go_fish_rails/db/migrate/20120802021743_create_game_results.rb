class CreateGameResults < ActiveRecord::Migration
  def change
    create_table :game_results do |t|
      t.string :state
      t.string :winner
      t.string :scores

      t.timestamps
    end
  end
end
