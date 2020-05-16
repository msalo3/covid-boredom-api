class AddIsFromUserToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :is_from_user, :boolean
  end
end
