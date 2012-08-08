class AddUserToGameResults < ActiveRecord::Migration
  def change
    add_column :game_results, :user, :integer
  end
end
