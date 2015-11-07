class ListsController < ApplicationController
  def index
    @list = List.new
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
    @list = current_user.lists.find(params[:id])
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
