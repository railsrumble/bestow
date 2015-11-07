class CreateListShares < ActiveRecord::Migration
  def change
    create_table :list_shares do |t|
      t.belongs_to :user, null: false, index: true, foreign_key: true
      t.belongs_to :list, null: false, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
