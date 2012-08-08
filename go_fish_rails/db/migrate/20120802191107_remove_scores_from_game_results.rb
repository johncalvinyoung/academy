class RemoveScoresFromGameResults < ActiveRecord::Migration
  def up
    remove_column :game_results, :scores
  end

  def down
    add_column :game_results, :scores, :string
  end
end
