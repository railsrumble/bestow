class InvitationsController < ApplicationController
  def create
    deliver_invitation
    redirect_with_notice
  end

  private

  def deliver_invitation
    @invitation = Invitation.new(invitation_params)
    @invitation.deliver
  end

  def invitation_params
    params.
      require(:invitation).
      permit(:email).
      merge(user: current_user, list: list)
  end

  def redirect_with_notice
    redirect_to @invitation.list, notice: "Invitation Sent"
  end

  def list
    @list ||= current_user.lists.find(params[:list_id])
  end
end
