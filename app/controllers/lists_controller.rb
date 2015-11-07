class ListsController < ApplicationController
  def index
    @list = List.new
    @lists = current_user.all_lists
  end

  def create
    list = List.new(list_params)

    if list.save
      redirect_to list_path(list), notice: "Success!!!"
    else
      @list = list
      render :index
    end
  end

  def show
    list = current_user.all_lists.find(params[:id]).first
    @presenter = ListPresenter.new(list, current_user)
  end

  private

  def list_params
    params.
      require(:list).
      permit(permitted_attributes).
      merge(user: current_user)
  end

  def permitted_attributes
    [:name]
  end
end
