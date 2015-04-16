class Api::V1::ItemsController < Api::BaseController

  def index
    @items = List.find(params[:list_id]).items
    render json: @items, each_serializer: ItemSerializer
  end

  def create
    @item = List.find(params[:list_id]).items.build(item_params)
    if @item.save
      render :json => {success: true, message: 'Item created.', 
                       item: {id: @item.id, content: @item.name}}, status: :created
    else
      render_error(422, 'Something went wrong. Item is not saved.')
    end
  end

  def show
    @item = set_item
    if !@item
      render_error(404, 'Item not found.')
    else
      render json: @item, serializer: ItemSerializer 
    end
  end

  def update
    @item = set_item
    if !@item
      render_error(404, 'Item not found.')
    elsif @item.update_atrributes!(item_params)
      render :json => {success: true, message: 'Item updated.', 
                       item: {id: @item.id, content: @item.name}}, status: :ok
    else
      render_error(422, 'Something went wrong. Item is not saved.')
    end
  end

  def destroy
    @item = set_item
    if !@item
      render_error(404, 'Item not found.')
    elsif @item.destroy
      render :json => {success: true, message: 'Item destroyed.'}, status: :ok
    else
      render_error(422)
    end
  end

  private 

  def item_params
    params.require(:item).permit(:name)
  end

  def set_item
    @item = Item.find_by_id(params[:id])
  end
end