class AddIndexToUsersNameAndPassword < ActiveRecord::Migration[5.2]
  def change
    add_index :users, :name, unique: true, where: 'name IS NOT NULL'
    add_index :users, :password, where: 'password IS NOT NULL'
  end
end
