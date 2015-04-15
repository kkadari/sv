require_relative '../modules/nav_ribbon'
require_relative '../modules/user_modal'

class UserOnePrivacyEditPage
  include PageObject
  include FigNewton
  include NavRibbon
  include UserModal

  page_url("#{FigNewton.base_url}/edit-profile-security!input.jspa?targetUser=#{FigNewton.user1_id}")

  def restrict_name
    @browser.select_list(:name => 'nameSecurityLevelID').select 'Connections'
    @browser.button(:name => 'save').when_present.click
  end
end
