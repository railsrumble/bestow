class InvitationMailer < ApplicationMailer
  def invitation(invitation_id)
    @invitation = Invitation.find(invitation_id)
    mail(to: @invitation.email)
  end
end
