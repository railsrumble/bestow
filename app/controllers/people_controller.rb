class PeopleController < ApplicationController
  def new
    @person = Person.new
  end

  def create
    person = Person.new(person_params)

    if person.save
      redirect_to list_path(list), notice: "YAY"
    else
      @person = person
      render :new
    end
  end

  def show
    @person = list.people.find(params[:id])
    @purchased_gifts = @person.purchased_gifts
    @gift_ideas = @person.gift_ideas
  end

  private

  def person_params
    params.
      require(:person).
      permit(permitted_attributes).
      merge(list: list)
  end

  def permitted_attributes
    [:amount, :avatar, :name]
  end

  def list
    @list ||= current_user.lists.find(params[:list_id])
  end
  helper_method :list
end