require_relative '../modules/nav_ribbon'
require_relative '../modules/user_modal'

class UserOneProfilePage
  include PageObject
  include NavRibbon
  include UserModal
  extend UrlFactory

  page_url(useroneprofilepage)

  def edit_profile
    @browser.link(:href => /edit-profile\!/).when_present.click
  end

  def click_activity
    @browser.link(:text => 'Activity').when_present.click
  end

  def click_content
    @browser.link(:xpath => '//*[@id="jive-content-tab"]/a').when_present.click
  end

  def click_thumbnail_view
    @browser.link(:xpath => '//*[@id="j-item-view-toggle"]/li[1]/a').when_present.click
  end

  def filter_by(text)
    @browser.text_field(:name => 'query').set text
    @browser.send_keys :return
  end

  def confirm_field_updated(field)
    fail unless @browser.html.to_s.include? field
  end

  def confirm_restriction_visible
    fail "Name not visible, and should be" unless @browser.html.include? TestConfig.user1_irlname
  end

  def confirm_restriction_invisible
    fail "Name visible, and should not be" if @browser.html.to_s.include? TestConfig.user1_irlname
  end

  def confirm_incident_report_invisible(subject)
    fail "Incident report visible, and should not be" if @browser.html.to_s.include? subject
  end

  def confirm_discussion_invisible(subject)
    fail "Discussion is visible and should not be" if @browser.html.to_s.include? subject
  end
end
