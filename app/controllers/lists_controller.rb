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
    list = find_list_for_current_user
    @presenter = ListPresenter.new(list, current_user)
  end

  def edit
    list = find_list_for_current_user
    if list
      @list = list
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  def update
    list = find_list_for_current_user

    if list
      list.update(list_params)

      if list.save
        redirect_to list_path(list), notice: "Success!!!"
      else
        @list = list
        render :edit
      end
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  def destroy
    list = find_list_for_current_user
    if list
      list.destroy
      redirect_to lists_path
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  private

  def find_list_for_current_user
    found_list = current_user.all_lists.detect do |list|
      list.id == params[:id].to_i
    end

    if found_list
      found_list
    else
      raise ActiveRecord::RecordNotFound
    end
  end

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
