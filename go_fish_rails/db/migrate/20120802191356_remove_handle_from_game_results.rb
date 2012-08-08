class RemoveHandleFromGameResults < ActiveRecord::Migration
  def up
    remove_column :game_results, :handle
  end

  def down
    add_column :game_results, :handle, :string
  end
end
