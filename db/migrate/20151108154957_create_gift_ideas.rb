class CreateGiftIdeas < ActiveRecord::Migration
  def change
    create_table :gift_ideas do |t|
      t.belongs_to :person, null: false, index: true, foreign_key: true
      t.string :name, null: false
      t.string :url
      t.integer :amount, null: false, default: true

      t.timestamps null: false
    end
  end
end
