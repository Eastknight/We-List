class ItemsController < ApplicationController
  respond_to :html, :js

  def create
    @list = List.find(params[:list_id])
    authorize @list, :create?
    @item = @list.items.build(item_params)
    if @item.save
      # flash[:notice] = "New item is added to your to-do list!"
    else
      flash[:error] = "There was an error. Please try again."
    end
    respond_with(@item) do |format|
      format.html { redirect_to @list }
    end 
  end

  def destroy
    @list = List.find(params[:list_id])
    authorize @list, :destroy?
    @item = @list.items.find(params[:id])
    if @item.destroy
      flash.now[:notice] = "Your to-do is complete!"
    else
      flash[:error] = "There was an error. Please try again."
    end 
    respond_with(@item) do |format|
      format.html { redirect_to @list }
    end   
  end

  def item_params
    params.require(:item).permit(:name)
  end

end
