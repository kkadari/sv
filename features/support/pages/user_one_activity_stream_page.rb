require_relative '../modules/nav_ribbon'
require_relative '../modules/user_modal'

class UserOneActivityStreamPage
  include PageObject
  include NavRibbon
  include UserModal
  
  page_url("#{FigNewton.base_url}/people/#{FigNewton.user1_id}/activity")

  def confirm_no_anon_content
    !fail 'Anonymous content visible' unless @browser.html.to_s.include? 'Anonymous'
  end

  def confirm_comment_is_anon
    sleep 4 # allow time for page to render
    browser.links(:class => "j-js-show-all j-expand").first.click
    sleep 4 # allow time for comment to display
    !fail 'Not marked as anonymous' unless browser.divs(:class => "j-act-comment").first.text.include? 'Anonymous'
    !fail 'Username visible' if browser.divs(:class => "j-act-comment").first.text.include? FigNewton.user1_uname
  end
end