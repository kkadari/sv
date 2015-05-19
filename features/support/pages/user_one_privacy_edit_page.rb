class UserOnePrivacyEditPage
  include PageObject
  extend UrlFactory

  page_url(useroneprivacyeditpage)

  def restrict_name
    @browser.select_list(:name => 'nameSecurityLevelID').select 'Connections'
    @browser.button(:name => 'save').when_present.click
  end
end
