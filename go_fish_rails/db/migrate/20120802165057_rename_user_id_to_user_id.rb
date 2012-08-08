class RenameUserIdToUserId < ActiveRecord::Migration
  def up
    rename_column(:game_results, :userid, :user_id)
  end

  def down
    rename_column(:game_results, :user_id, :userid)
  end
end
