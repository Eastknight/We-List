class ListsController < ApplicationController
  before_action :authenticate_user! # users must be signed in before any lists_controller method
  
  def show
    @list = current_user.list
    @item = Item.new
    @items = @list.items
    respond_to do |format|
      format.html
      format.json {render :json => @user}
    end
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
    @list = List.find(params[:id])
    if @list.update_attributes!(list_params)
      flash[:notice] = "List name was updated."
      respond_to do |format|
        format.html {redirect_to @list}
        format.json {render :json => @list}
      end
    else
      flash[:error] = "There was an error. Please try again."
      respond_to do |format|
        format.html {redirect_to @list}
        format.json {render :nothing => true}
      end
    end
  end

  private

  def list_params
    params.require(:list).permit(:title)
  end
end