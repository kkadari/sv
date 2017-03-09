class ViewGroupPage
  include PageObject
  extend UrlFactory

  page_url(grouppage)

  div(:activity_stream, :class => '.j-stream')
  image(:place_image, :class => '.placeImg')

end
