class PreferencesPage
  include PageObject
  extend UrlFactory
  
  page_url(preferencespage)

  button(:save,:name => 'save')
  select_list(:timezone, :id => 'jive-timezone')
  
  def change_timezone_to(value)

  end
end