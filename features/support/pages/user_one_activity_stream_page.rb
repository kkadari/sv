require_relative '../modules/nav_ribbon'
require_relative '../modules/user_modal'

class UserOneActivityStreamPage
  include PageObject
  include NavRibbon
  include UserModal
  extend UrlFactory

  page_url(useroneactivitystreampage)

  def confirm_no_anon_content
    !fail 'Anonymous content visible' unless @browser.html.to_s.include? 'Anonymous'
  end

  def confirm_comment_is_anon
    browser.links(:class => "j-js-show-all j-expand").first.click
    !fail 'Not marked as anonymous' unless browser.divs(:class => "j-act-comment").first.text.include? 'Anonymous'
    !fail 'Username visible' if browser.divs(:class => "j-act-comment").first.text.include? TestConfig.user1_uname
  end
end
