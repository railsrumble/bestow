class Person < ActiveRecord::Base
  belongs_to :list

  has_many :gift_ideas, dependent: :destroy
  has_many :purchased_gifts, dependent: :destroy

  validates :name, presence: true
  has_attached_file :avatar,
                    styles: { medium: "300x300", thumb: "100x100" },
                    default_url: "missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage/
end
