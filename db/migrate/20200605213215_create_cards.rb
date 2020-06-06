class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.string :name
      t.text :info
      t.boolean :vertical
      t.boolean :sold
      t.boolean :main_image

      t.timestamps
    end
  end
end
