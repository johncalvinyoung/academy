class AddPlayersToUser < ActiveRecord::Migration
  def change
    add_column :users, :players, :string
  end
end
