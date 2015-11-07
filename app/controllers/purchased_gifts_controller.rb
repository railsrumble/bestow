class PurchasedGiftsController < ApplicationController
  def new
    @purchased_gift = PurchasedGift.new
  end

  def create
    purchased_gift = PurchasedGift.new(purchased_gift_params)

    if purchased_gift.save
      redirect_to list_person_path(list, person), notice: "Success!"
    else
      @purchased_gift = purchased_gift
      render :new
    end
  end

  private

  def purchased_gift_params
    params.
      require(:purchased_gift).
      permit(permitted_attributes).
      merge(person: person)
  end

  def permitted_attributes
    [:amount, :name, :url]
  end

  def person
    @person ||= list.people.find(params[:person_id])
  end
  helper_method :person

  def list
    @list ||= current_user.lists.find(params[:list_id])
  end
  helper_method :list
end
