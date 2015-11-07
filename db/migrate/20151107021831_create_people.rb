class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name, null: false
      t.float :amount, null: false, default: 0
      t.belongs_to :user, null: false, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
