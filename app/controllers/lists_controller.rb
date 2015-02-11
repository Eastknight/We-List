class ListsController < ApplicationController
  before_action :authenticate_user! # users must be signed in before any lists_controller method

  def show
    @list = current_user.list
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    @list.user = current_user
    if @list.save
      flash[:notice] = "List was saved. Add your to-do items now."
      redirect_to @list
    else
      flash[:error] = "There was an error. Please try again."
      render :new
    end
  end

  def update
    @list = current_user.list
    if @list.update_attributes(list_params)
      flash[:notice] = "Post was updated."
      redirect_to @list
    else
      flash[:error] = "There was an error. Please try again."
      render :show
    end
  end

  private

  def list_params
    params.require(:list).permit(:title)
  end
end