class InvitationsController < ApplicationController
  def create
    if user_exists?
      share_list
    else
      deliver_invitation
    end

    redirect_with_notice
  end

  private

  attr_reader :user

  def deliver_invitation
    @invitation = Invitation.new(invitation_params)
    @invitation.deliver
  end

  def share_list
    shared_list = ListShare.create(list: list, user: user)
    @redirect_location = shared_list.list
  end

  def invitation_params
    params.
      require(:invitation).
      permit(:email).
      merge(user: current_user, list: list)
  end

  def redirect_with_notice
    redirect_to redirect_location, notice: "Invitation Sent"
  end

  def list
    @list ||= current_user.lists.find(params[:list_id])
  end

  def redirect_location
    @redirect_location || @invitation.list
  end

  def user_exists?
    @user = User.find_by(email: invitation_params[:email])
  end
end
