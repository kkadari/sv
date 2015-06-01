module TestConfig

  @test_user_sets = [{
    :user_1_name      => ENV['user1_uname'],
    :user_1_password  => ENV['user1_pswd'],
    :user_2_name      => ENV['user2_uname'],
    :user_2_password  => ENV['user2_pswd'],
    :admin_name       => ENV['adminuser_uname'],
    :admin_password   => ENV['adminuser_pswd'],
    :private_group    => ENV['private_group'],
    :secret_group     => ENV['secret_group'],
    :custom_space     => ENV['custom_space']
  },{
    :user_1_name      => ENV['user2_uname'],
    :user_1_password  => ENV['user2_pswd'],
    :user_2_name      => ENV['user2_uname'],
    :user_2_password  => ENV['user2_pswd'],
    :admin_name       => ENV['adminuser_uname'],
    :admin_password   => ENV['adminuser_pswd'],
    :private_group    => ENV['private_group'],
    :secret_group     => ENV['secret_group'],
    :custom_space     => ENV['custom_space']
  }]

  def self.get_config_set(id)
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

end