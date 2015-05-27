class TestConfig

  class << self

    def user1_uname
      ENV['user1_uname']
    end

    def user1_pswd
      ENV['user1_pswd']
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

    def groups_and_spaces(level)
      case level
        when 'private group'
          self.custom_group
        when 'secret group'
          self.secret_group
        when 'space'
          self.custom_space
        else
          raise 'Something went wrong. Sorry about that.'
      end
    end

  end

end
