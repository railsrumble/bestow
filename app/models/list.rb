class List < ActiveRecord::Base
  belongs_to :user

  has_many :people

  validates :name, presence: true
  validates :user, presence: true
end
