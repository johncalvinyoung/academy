class RemovePlayersFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :players
  end

  def down
    add_column :users, :players, :string
  end
end
