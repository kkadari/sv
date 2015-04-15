require_relative '../modules/nav_ribbon'
require_relative '../modules/user_modal'

class CustomGroupPage
  include PageObject
  include FigNewton
  include NavRibbon
  include UserModal

  page_url("#{FigNewton.base_url}/#{custom_group}")

  link(:content_page, :href => "/groups/#{custom_group}/content")

  def follow_in_connections_stream
    follow = @browser.link(:id => 'jive-link-socialgroup-startFollowing')
    following = @browser.link(:id => 'jive-link-socialgroup-following')

    follow.click unless following.present?
  end

  def view_content_page
    @browser.link(:href => "/groups/#{custom_group}/content").wait_until_present
    content_page
  end
end
