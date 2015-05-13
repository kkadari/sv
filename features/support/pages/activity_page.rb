require_relative '../modules/nav_ribbon'
require_relative '../modules/user_modal'

class ActivityPage
  include PageObject
  include NavRibbon
  include UserModal
  extend UrlFactory

  page_url(activitypage)

  def confirm_first_ir_is_anonymous

    incident_report = browser.divs(:class => 'j-act-entry').first
    !fail 'Not marked with anonymous avatar' unless incident_report.html.to_s.include? 'anonymous-avatar'
    !fail 'Not marked as anonymous' unless incident_report.text.include? 'Anonymous'
    !fail 'Username visible' if incident_report.text.include? TestConfig.user2_uname
  end

end
