class AcceptancesController < ApplicationController
  def new
    @acceptance = build_acceptance(email: find_invitation.email)
  end

  def create
    @acceptance = build_acceptance(acceptance_attributes)

    if @acceptance.save
      sign_in @acceptance.user
      redirect_to @acceptance.list
    else
      render :new
    end
  end

  private

  def build_acceptance(attributes = {})
    Acceptance.new(find_invitation, attributes)
  end

  def find_invitation
    @invitation ||= Invitation.find_by(code: params[:invitation_id])
  end

  def acceptance_attributes
    params.require(:acceptance).permit(:email, :password)
  end
end
