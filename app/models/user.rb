class User < ActiveRecord::Base
  include Clearance::User

  has_many :invitations
  has_many :lists
  has_many :list_shares
  has_many :others_lists, through: :list_shares, source: :list

  def all_lists
    lists + others_lists
  end
end
