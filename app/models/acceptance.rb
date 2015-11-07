class Acceptance
  include ActiveModel::Model

  attr_reader :invitation, :user

  delegate :errors, :email, :password, to: :user
  delegate :list, to: :invitation

  validate :unused_invitation

  def initialize(invitation, attributes)
    @invitation = invitation
    @user_attributes = attributes
    @user = build_user
  end

  def save
    valid? && user.save && invitation.accept && share_list
  end

  def valid?
    super && user.valid?
  end

  private

  attr_reader :user_attributes

  def share_list
    ListShare.create(list: invitation.list, user: user)
  end

  def unused_invitation
    if invitation.accepted?
      errors.add :invitation, "has already been accepted"
    end
  end

  def build_user
    User.new(user_attributes)
  end
end
