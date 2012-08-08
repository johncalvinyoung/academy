class AddHandleToGameResult < ActiveRecord::Migration
  def change
    add_column :game_results, :handle, :string
  end
end
