Given /^I? (?:am|have) logged in as "([^\"]+)"$/ do |login|

  @user_logged_in = @browser.link(:id => 'j-satNav').present?
  if @user_logged_in then
    visit(HomePage).log_out
  end

  user = "#{login}"
  case user
    when user = 'participant A'
      visit(LoginPage).log_in username = user1_uname, password = user1_pswd
    when user = 'participant B'
      visit(LoginPage).log_in username = user2_uname, password = user2_pswd
    when user = 'admin'
      visit(LoginPage).log_in username = adminuser_uname, password = adminuser_pswd
    else
      fail 'Supplied user not recognised.'
  end
end
