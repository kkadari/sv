module UserModal
  include PageObject

  def log_out
    @browser.link(:text => 'Logout').when_present.click
    @browser.div(:id => "jive-login-formblock").wait_until_present
  end

  def open_preferences
    @browser.link(:id => 'j-satNav').when_present.click
    @browser.link(:href => "/user-preferences!input.jspa").when_present.click
  end
end