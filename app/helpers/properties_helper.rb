module PropertiesHelper

  def property_thumbnail property
    img = property.image.present? ? property.image.url : "placeholder.png"
    image_tag img, class: "property-thumb"
  end

  def property_thumbnail_url property
    property.image.present? ? property.image.url : "placeholder.png"
  end

  def property_photo_url property
    property.image.present? ? property.image.url : asset_url("placeholder.png")

  end



end
