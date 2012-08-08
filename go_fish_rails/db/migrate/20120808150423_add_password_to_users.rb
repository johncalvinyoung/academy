class AddPasswordToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_column :users, :password, :string
    add_column :users, :token, :string
    add_column :users, :token_expires_at, :datetime
  end
end
