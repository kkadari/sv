class TestConfig

  class << self

    def user1_irlname
      ENV['user1_irlname']
    end

    def user1_surname
      ENV['user1_surname']
    end

    def user1_uname
      ENV['user1_uname']
    end

    def user1_pswd
      ENV['user1_pswd']
    end

    def user1_id
      ENV['user1_id']
    end

    def user2_uname
      ENV['user2_uname']
    end

    def user2_pswd
      ENV['user2_pswd']
    end

    def user3_uname
      ENV['user3_uname']
    end

    def user3_pswd
      ENV['user3_pswd']
    end

    def adminuser_uname
      ENV['adminuser_uname']
    end

    def adminuser_pswd
      ENV['adminuser_pswd']
    end

    def custom_group
      ENV['custom_group']
    end

    def secret_group
      ENV['secret_group']
    end

    def custom_space
      ENV['custom_space']
    end

  end

end
