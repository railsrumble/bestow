class User < ActiveRecord::Base
  include Clearance::User

  has_many :invitations
  has_many :lists, dependent: :destroy
  has_many :list_shares
  has_many :others_lists, through: :list_shares, source: :list

  def all_lists
    @all_lists ||= List.where("user_id = ? OR id IN (#{share_list_select})", id, id)
  end

  def share_list_select
    "SELECT list_id
     FROM list_shares
     WHERE user_id = ?"
  end
end
