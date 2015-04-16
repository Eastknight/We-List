class ListPreviewSerializer < ActiveModel::Serializer
  attributes :id, :title, :number_of_items, :user_id

  def number_of_items
    object.items.count
  end
end
