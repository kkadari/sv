class TestConfig
  
  attr_reader :user1_uname
  attr_reader :user1_pswd
  
  def initialize
    @user1_uname = ENV['user1_uname']
    @user1_pswd = ENV['user1_pswd']
  end
  
end
