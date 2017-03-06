class ViewSpacePage
  include PageObject
  extend UrlFactory

  page_url(spacepage)

  link(:subspace,:href => /\/community\/test-space\/places\//)
  div(:activity_stream, :class => '.j-stream')
  image(:place_image, :class => '.placeImg')

end
