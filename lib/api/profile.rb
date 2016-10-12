class Profile < Request

  def self.get_edit_profile(user_id, cookies)
    RestClient.get(ENV['base_url'] + '/edit-profile!input.jspa?targetUser=' + user_id,:cookie => Request.create_cookie(cookies)){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200

      return response
    }
  end

  def self.post_edit_profile(payload, cookies)
    RestClient.post(ENV['base_url'] + '/edit-profile.jspa',payload,:cookie => Request.create_cookie(cookies)){|response|
      p 'EDIT PROFILE PL: ' + response
      fail('Failed with ' + response.code.to_s) if response.code != 302
    }
  end

  def self.get_edit_privacy_profile(user_id, cookies)
    RestClient.get(ENV['base_url'] + '/edit-profile-security!input.jspa?targetUser=' + user_id,:cookie => Request.create_cookie(cookies)){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200

      return response
    }
  end

  def self.post_edit_privacy_profile(payload, cookies)
    RestClient.post(ENV['base_url'] + '/edit-profile-security.jspa',payload,:cookie => Request.create_cookie(cookies)){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 302
    }
  end

  def self.get_people_followed(username, cookies)
    RestClient.get(ENV['base_url'] + '/people/' + username + '/people', :cookie => Request.create_cookie(cookies)){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200

      return response
    }
  end

end
