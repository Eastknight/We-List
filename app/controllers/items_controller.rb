class ItemsController < ApplicationController

  def create
    @list = List.find(params[:list_id])
    @item = @list.items.build(item_params)
    if @item.save
      flash[:notice] = "List was saved. Add your to-do items now."
      redirect_to @list
    else
      flash[:error] = "There was an error. Please try again."
      render :new
    end
  end

  def item_params
    params.require(:item).permit(:name)
  end

end
