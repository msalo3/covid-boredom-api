class CreateCardsAndCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.string :name
      t.text :info
      t.boolean :vertical
      t.boolean :sold
      t.boolean :main_image

      t.timestamps
    end

    create_table :categories do |t|
      t.string :name
      t.timestamps
    end

    create_table :cards_categories, id: false do |t|
      t.belongs_to :card
      t.belongs_to :category
    end
  end
end
