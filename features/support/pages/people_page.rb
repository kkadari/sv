require_relative '../modules/nav_ribbon'
require_relative '../modules/user_modal'

class PeoplePage
  include PageObject
  include NavRibbon
  include UserModal

  page_url(UrlFactory.peoplepage)

  link(:user1_profile, :href => "/people/#{TestConfig.user1_uname.gsub(/\s+/, "")}")
  link(:user2_profile, :href => "/people/#{TestConfig.user2_uname.gsub(/\s+/, "")}")
  link(:user3_profile, :href => "/people/#{TestConfig.user3_uname.gsub(/\s+/, "")}")
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
        fail "Unknown user provided"
    end
  end

  def search_for_user(name)
    @browser.text_field(:name => 'query').set name
    @browser.send_keys :return
  end

  def click_result(name)
    result = "people\/#{TestConfig.user1_id}"
    @browser.link(:href => /#{result}/).when_present.click
  end

  def navigate_directly_to_profile_of(username)
    browser.goto UrlFactory.peoplepage + "/" + username
  end

  def verify_not_found
    fail 'Person profile unexpectedly displayed' unless @browser.html.to_s.include? 'Not Found'
  end

end
