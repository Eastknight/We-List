class ListsController < ApplicationController
  before_action :authenticate_user! 

  def index
    @lists = current_user.lists
  end
  
  def show
    @list = List.find(params[:id])
    authorize @list
    @item = Item.new
    @items = @list.items
    respond_to do |format|
      format.html
      format.json {render :json => @list}
    end
  end

  def create
    @list = current_user.lists.build(list_params)
    authorize @list
    if @list.save
      flash[:notice] = "List was saved. Add your to-do items now."
      redirect_to list_path(@list)
    else
      flash[:error] = "There was an error. Please try again."
      redirect_to lists_path
    end
  end

  def update
    @list = List.find(params[:id])
    authorize @list
    if @list.update_attributes!(list_params)
      # flash[:notice] = "List was updated."
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

  def destroy
    @list = List.find(params[:id])
    authorize @list
    if @list.destroy
      flash[:notice] = "List name was deleted."
      redirect_to lists_path
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