class TestConfig

  attr_reader :user1_irlname
  attr_reader :user1_surname
  attr_reader :user1_uname
  attr_reader :user1_uname_en
  attr_reader :user1_pswd
  attr_reader :user1_id

  attr_reader :user2_irlname
  attr_reader :user2_surname
  attr_reader :user2_uname
  attr_reader :user2_uname_en
  attr_reader :user2_pswd
  attr_reader :user2_id

  attr_reader :user3_irlname
  attr_reader :user3_surname
  attr_reader :user3_uname
  attr_reader :user3_uname_en
  attr_reader :user3_pswd
  attr_reader :user3_id

  attr_reader :adminuser_irlname
  attr_reader :adminuser_uname
  attr_reader :adminuser_uname_en
  attr_reader :adminuser_pswd

  attr_reader :custom_group
  attr_reader :secret_group
  attr_reader :custom_space

  def initialize
    @user1_irlname        = ENV['user1_irlname']
    @user1_surname        = ENV['user1_surname']
    @user1_uname          = ENV['user1_uname']
    @user1_uname_en       = ENV['user1_uname_en']
    @user1_pswd           = ENV['user1_pswd']
    @user1_id             = ENV['user1_id']

    @user2_irlname        = ENV['user2_irlname']
    @user2_surname        = ENV['user2_surname']
    @user2_uname          = ENV['user2_uname']
    @user2_uname_en       = ENV['user2_uname_en']
    @user2_pswd           = ENV['user2_pswd']
    @user2_id             = ENV['user2_id']

    @user3_irlname        = ENV['user3_irlname']
    @user3_surname        = ENV['user3_surname']
    @user3_uname          = ENV['user3_uname']
    @user3_uname_en       = ENV['user3_uname_en']
    @user3_pswd           = ENV['user3_pswd']
    @user3_id             = ENV['user3_id']

    @adminuser_irlname    = ENV['adminuser_irlname']
    @adminuser_uname      = ENV['adminuser_uname']
    @adminuser_uname_en   = ENV['adminuser_uname_en']
    @adminuser_pswd       = ENV['adminuser_pswd']
  end

  def self.custom_group
    ENV['custom_group']
  end

  def self.secret_group
    ENV['secret_group']
  end

  def self.custom_space
    ENV['custom_space']
  end

end
