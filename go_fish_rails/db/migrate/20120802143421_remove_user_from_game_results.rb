class RemoveUserFromGameResults < ActiveRecord::Migration
  def up
    remove_column :game_results, :user
  end

  def down
    add_column :game_results, :user, :integer
  end
end
