class LoginPage
  include PageObject
  extend UrlFactory

  page_url(loginpage)

  text_field(:username, :name => "username")
  text_field(:password, :id => "password01")
  
  def log_in(username, password)
    self.username = username
    self.password = password
    @browser.button(:id => "login-submit").when_present.click
  end

end
