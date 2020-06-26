class CardSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :name, :info, :vertical, :sold, :main_image, :image, :categories, :updated_at

  def updated_at
    object.updated_at.to_date
  end

  def categories
    object.categories.map { |cat| cat.name }
  end

  def image
    return unless object.image.attached?

    object.image.blob.attributes
          .slice('filename', 'byte_size')
          .merge(url: image_url)
          .tap { |attrs| attrs['name'] = attrs.delete('filename') }
  end

  def image_url
    url_for(object.image)
  end
end
