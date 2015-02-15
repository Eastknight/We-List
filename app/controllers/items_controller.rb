class ItemsController < ApplicationController

  def create
    @list = List.find(params[:list_id])
    @item = @list.items.build(item_params)
    if @item.save
      flash[:notice] = "New item is added to your to-do list!"
      redirect_to @list
    else
      flash[:error] = "There was an error. Please try again."
      redirect_to @list
    end
  end

  def destroy
    @list = List.find(params[:list_id])
    @item = @list.items.find(params[:id])
    if @item.destroy
      flash[:notice] = "You've successfully marked it as complete!"
      redirect_to @list
    else
      flash[:error] = "There was an error. Please try again."
      redirect_to @list
    end    
  end

  def item_params
    params.require(:item).permit(:name)
  end

end
