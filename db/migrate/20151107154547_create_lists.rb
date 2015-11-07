class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :name, null: false
      t.belongs_to :user, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end

    ActiveRecord::Base.connection.execute("DELETE from people")
    remove_reference :people, :user, index: true, foreign_key: true
    add_reference :people, :list, index: true, foreign_key: true, null: false
  end
end
