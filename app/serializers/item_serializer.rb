class ItemSerializer < ActiveModel::Serializer
  attributes :id, :content, :created_at, :list_id

  def content
    object.name
  end
end
