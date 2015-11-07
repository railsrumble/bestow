class CreatePurchasedGifts < ActiveRecord::Migration
  def change
    create_table :purchased_gifts do |t|
      t.belongs_to :person, null: false, index: true, foreign_key: true
      t.string :name, null: false
      t.string :url
      t.float :amount, null: false, default: 0

      t.timestamps null: false
    end
  end
end
