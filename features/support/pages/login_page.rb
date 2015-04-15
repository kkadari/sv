class LoginPage
  include PageObject
  include FigNewton

  page_url("#{FigNewton.base_url}/login.jspa")

  text_field(:username, :name => "username")
  text_field(:password, :id => "password01")

  def log_in(username = FigNewton.user1_uname, password = FigNewton.user1_pswd)
    puts username
    puts password
    self.username = username
    self.password = password
    @browser.button(:id => "login-submit").when_present.click
  end

end
