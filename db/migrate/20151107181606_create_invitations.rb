class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.belongs_to :list, index: true, foreign_key: true, null: false
      t.belongs_to :user, index: true, foreign_key: true, null: false
      t.string :email, null: false
      t.string :code, null: false
      t.timestamp :accepted_at

      t.timestamps null: false
    end
  end
end
