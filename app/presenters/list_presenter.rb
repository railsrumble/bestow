class ListPresenter
  attr_reader :list

  def initialize(list, user)
    @list = list
    @user = user
  end

  def invitation
    list.invitations.build
  end

  def total_amount
    people.sum(:amount)
  end

  def show_invitation?
    !shared_list?
  end

  def people
    list.people
  end

  def name
    if shared_list?
      "#{list.name} (shared from #{list.user_email})"
    else
      list.name
    end
  end

  private

  attr_reader :user

  def shared_list?
    list.user != user
  end
end
