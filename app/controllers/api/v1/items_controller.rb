class Api::V1::ItemsController < Api::BaseController

  def index
    @list = List.find_by_id(params[:list_id])
    if !@list
      render_error(404, 'List not found.') and return
    end
    authorize @list, :show?
    @items = @list.items
    render json: @items, each_serializer: ItemSerializer
  end

  def create
    @list = List.find_by_id(params[:list_id])
    if !@list
      render_error(404, 'List not found.') and return
    end
    authorize @list, :show?
    @item = @list.items.build(item_params)
    if @item.save
      render :json => {success: true, message: 'Item created.', 
                       item: {id: @item.id, content: @item.name, list_id: @item.list_id}}, status: :created
    else
      render_error(422, 'Something went wrong. Item is not saved.')
    end
  end

  def show
    @item = set_item
    if !@item
      render_error(404, 'Item not found.') and return 
    end
    authorize @item
    render json: @item, serializer: ItemSerializer 
  end

  def update
    @item = set_item
    if !@item
      render_error(404, 'Item not found.') and return
    end
    authorize @item
    if @item.update_atrributes!(item_params)
      render :json => {success: true, message: 'Item updated.', 
                       item: {id: @item.id, content: @item.name, list_id: @item.list_id}}, status: :ok
    else
      render_error(422, 'Something went wrong. Item is not saved.')
    end
  end

  def destroy
    @item = set_item
    if !@item
      render_error(404, 'Item not found.') and return 
    end
    authorize @item
    if @item.destroy
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