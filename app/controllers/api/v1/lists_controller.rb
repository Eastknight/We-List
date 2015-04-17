class Api::V1::ListsController < Api::BaseController
  def index
    @lists = current_user.lists
    render json: @lists, each_serializer: ListPreviewSerializer
  end

  def create
    @list = current_user.lists.build(list_params)
    authorize @list
    if @list.save
      render :json => {success: true, message: 'List created.', 
                       list: {id: @list.id, title: @list.title, user_id: @list.user_id}}, status: :created
    else
      render_error(422, 'Something went wrong. List is not saved.')
    end
  end

  def show
    set_list
    if !@list
      render_error(404, 'List not found.') and return
    end
    authorize @list
    render json: @list, serializer: ListSerializer 
  end

  def update
    set_list
    if !@list
      render_error(404, 'List not found.') and return
    end
    authorize @list    
    if @list.update_attributes(list_params)
      render :json => {success: true, message: 'List updated.', 
                       list: {id: @list.id, title: @list.title, user_id: @list.user_id}}, status: :ok
    else
      render_error(422, 'Something went wrong. List is not saved.')
    end
  end

  def destroy
    set_list
    if !@list
      render_error(404, 'List not found.') and return
    end
    authorize @list 
    if @list.destroy
      render :json => {success: true, message: 'List destroyed.'}, status: :ok
    else
      render_error(422)
    end
  end

  def preview
    set_list
    if !@list
      render_error(404, 'List not found.') and return
    end
    authorize @list, :show?
    render json: @list, serializer: ListPreviewSerializer
  end

  private 

  def list_params
    params.require(:list).permit(:title)
  end

  def set_list
    @list = List.find_by_id(params[:id])
  end
end