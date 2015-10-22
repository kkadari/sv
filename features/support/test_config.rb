module TestConfig

  @test_user_sets = [{
    :user_1_name      => ENV['user1_uname'],
    :user_1_password  => ENV['user1_pswd'],
    :user_1_id        => ENV['user1_id'],
    :user_2_name      => ENV['user2_uname'],
    :user_2_password  => ENV['user2_pswd'],
    :user_2_id        => ENV['user2_id'],
    :admin_name       => ENV['adminuser_uname'],
    :admin_password   => ENV['adminuser_pswd'],
    :admin_id         => ENV['admin_id'],
    :private_group    => ENV['private_group'],
    :secret_group     => ENV['secret_group'],
    :space            => ENV['custom_space']
  }]

  def self.get_config_set
    id = ENV['TEST_ENV_NUMBER']

    begin
      if id.to_i > 1
        @test_user_sets[1]
      else
        @test_user_sets[id.to_i]
      end
    rescue
      @test_user_sets[1]
    end
  end

  def self.return_profile(user)
    config = @test_user_sets[ENV['TEST_ENV_NUMBER'].to_i]

    case user
      when 'participant A'
        { :username => config[:user_1_name], :password => config[:user_1_password], :user_id => config[:user_1_id] }
      when 'participant B'
        { :username => config[:user_2_name], :password => config[:user_2_password], :user_id => config[:user_2_id] }
      when 'admin'
        { :username => config[:admin_name], :password => config[:admin_password], :user_id => config[:admin_id] }
      else
        fail 'Supplied user not recognised.'
    end
  end

  def self.return_space
    config = @test_user_sets[ENV['TEST_ENV_NUMBER'].to_i]

    config[:space]
  end

end
