class Invitation < ActiveRecord::Base
  belongs_to :list
  belongs_to :user

  validates :email, presence: true
  validates :list, presence: true
  validates :user, presence: true

  delegate :email, to: :user, prefix: true

  time_for_a_boolean :accepted

  def initialize(attributes = {}, options = {})
    super
    generate_code
  end

  def deliver
    if save
      send_email
      true
    else
      false
    end
  end

  def to_param
    code
  end

  def accept
    update!(accepted_at: Time.current)
  end

  private

  def generate_code
    self.code = SecureRandom.hex(16)
  end

  def send_email
    InvitationMailer.invitation(id).deliver_later
  end
end
