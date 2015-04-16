class Api::V1::ListsController < Api::BaseController
  def index
    # return permission_denied_error unless conditions_met
    @lists = current_user.lists
    render json: @lists, each_serializer: ListPreviewSerializer
  end

  def create
    @list = current_user.lists.build(list_params)
    if @list.save
      render :json => {success: true, message: 'List created.', 
                       list: {id: @list.id, title: @list.title}}, status: :created
    else
      render_error(422, 'Something went wrong. List is not saved.')
    end
  end

  def show
    set_list
    if !@list
      render_error(404, 'List not found.')
    else
      render json: @list, serializer: ListSerializer 
    end
  end

  def update
    set_list
    if !@list
      render_error(404, 'List not found.')
    elsif @list.update_attributes(list_params)
      render :json => {success: true, message: 'List updated.', 
                       list: {id: @list.id, title: @list.title}}, status: :ok
    else
      render_error(422, 'Something went wrong. List is not saved.')
    end
  end

  def destroy
    set_list
    if !@list
      render_error(404, 'List not found.')
    elsif @list.destroy
      render :json => {success: true, message: 'List destroyed.'}, status: :ok
    else
      render_error(422)
    end
  end

  def preview
    set_list
    if !@list
      render_error(404, 'List not found.')
    else
      render json: @list, serializer: ListPreviewSerializer
    end
  end

  private 

  def list_params
    params.require(:list).permit(:title)
  end

  def set_list
    @list = List.find_by_id(params[:id])
  end
end