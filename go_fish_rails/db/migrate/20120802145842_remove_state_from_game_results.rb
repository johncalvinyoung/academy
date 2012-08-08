class RemoveStateFromGameResults < ActiveRecord::Migration
  def up
    remove_column :game_results, :state
  end

  def down
    add_column :game_results, :state, :text
  end
end
