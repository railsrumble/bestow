class GiftIdeasController < ApplicationController
  def new
    @gift_idea = GiftIdea.new(gift_idea_params)
  end

  def create
    gift_idea = GiftIdea.new(gift_idea_params)

    if gift_idea.save
      redirect_to list_person_path(list, person), notice: "Success!"
    else
      @gift_idea = gift_idea
      render :new
    end
  end

  private

  def list
    @list ||= current_user.lists.find(params[:list_id])
  end
  helper_method :list

  def person
    @person ||= list.people.find(params[:person_id])
  end
  helper_method :person

  def gift_idea_params
    if params[:gift_idea]
      params.
        require(:gift_idea).
        permit(permitted_attributes).
        merge(person: person)
    else
      {amount: 0}
    end
  end

  def permitted_attributes
    [:amount, :name, :url]
  end
end
