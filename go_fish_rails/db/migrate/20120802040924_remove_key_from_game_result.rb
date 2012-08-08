class RemoveKeyFromGameResult < ActiveRecord::Migration
  def up
    remove_column :game_results, :key
  end

  def down
    add_column :game_results, :key, :string
  end
end
