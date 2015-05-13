require_relative '../modules/nav_ribbon'
require_relative '../modules/user_modal'

class UserOnePrivacyEditPage
  include PageObject
  include NavRibbon
  include UserModal
  extend UrlFactory

  page_url(useroneprivacyeditpage)

  def restrict_name
    @browser.select_list(:name => 'nameSecurityLevelID').select 'Connections'
    @browser.button(:name => 'save').when_present.click
  end
end
