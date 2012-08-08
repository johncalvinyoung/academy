class AddUserIdToGameResults < ActiveRecord::Migration
  def change
    add_column :game_results, :userid, :integer
  end
end
