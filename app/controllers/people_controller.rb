class PeopleController < ApplicationController
  def index
    @people = current_user.people
  end

  def new
    @person = Person.new
  end

  def create
    person = Person.new(person_params)

    if person.save
      redirect_to people_path, notice: "YAY"
    else
      @person = person
      render :new
    end
  end

  private

  def person_params
    params.
      require(:person).
      permit(permitted_attributes).
      merge(user: current_user)
  end

  def permitted_attributes
    [:amount, :avatar, :name]
  end
end
