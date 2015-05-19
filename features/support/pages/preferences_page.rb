class PreferencesPage
  include PageObject
  extend UrlFactory
  
  page_url(preferencespage)
  
  def change_timezone_to(value)
    @browser.select_list(:id => "jive-timezone").when_present.select_value(value)
    @browser.button(:name => "save").when_present.click
  end
end