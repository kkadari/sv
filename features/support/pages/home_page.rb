class HomePage
  include PageObject
  extend UrlFactory

  page_url(homepage)
  
  link(:connections_stream, :text => 'Connections Stream')

end
