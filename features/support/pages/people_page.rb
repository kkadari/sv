require_relative '../modules/nav_ribbon'
require_relative '../modules/user_modal'

class PeoplePage
  include PageObject
  include NavRibbon
  include UserModal

  page_url(UrlFactory.peoplepage)

  link(:user1_profile, :title => TestConfig.user1_uname)
  link(:user2_profile, :title => TestConfig.user2_uname)
  link(:user3_profile, :title => TestConfig.user3_uname)
  text_area(:search, :name => 'query')

  def view_profile(user = 'user1')
    case user
      when 'user1'
        user1_profile
      when 'user2'
        user2_profile
      when 'user3'
        user3_profile
      else
        raise "Unknown user provided"
    end
  end

  def search_for_user(name)
    @browser.text_field(:name => 'query').set name
    @browser.send_keys :return
  end

  def click_result(name)
    result = "people/#{TestConfig.user1_id}"
    @browser.link(:href => /#{result}/).when_present.click
  end

end
