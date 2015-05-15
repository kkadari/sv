class LoginPage
  include PageObject
  extend UrlFactory

  page_url(loginpage)

  text_field(:username, :name => 'username')
  text_field(:password, :id => 'password01')
  button(:submit, :id => 'login-submit')
  
  def log_in(uname, pswd)
    self.username = uname
    self.password = pswd
    submit
  end

end
