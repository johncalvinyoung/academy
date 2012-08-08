class AddKeyToGameResult < ActiveRecord::Migration
  def change
    add_column :game_results, :key, :string
  end
end
