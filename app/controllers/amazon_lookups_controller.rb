class AmazonLookupsController < ApplicationController
  def create
    if is_empty?(gift_idea_params)
      redirect_with_error
    else
      redirect_to new_list_person_gift_idea_path(
        list,
        person,
        gift_idea: gift_idea_params,
        amazon_lookup_complete: true
      )
    end
  rescue
    redirect_with_error
  end

  private

  def is_empty?(hash)
    hash.values.all?(&:blank?)
  end

  def gift_idea_params
    {
      name: amazon_information.name,
      url: amazon_information.url,
      amount: amazon_information.amount,
    }
  end

  def url
    params[:amazon_lookup][:url]
  end

  def amazon_information
    @amazon_information ||= AmazonInformationFinder.new(url)
  end

  def redirect_with_error
    flash[:error] = "Sorry, we could not locate the information for that item"
    redirect_to new_list_person_gift_idea_path(list, person)
  end

  def list
    params[:amazon_lookup][:list]
  end

  def person
    params[:amazon_lookup][:person]
  end
end
