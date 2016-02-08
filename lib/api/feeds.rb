class Feeds < Request

  def self.get_activity(cookies)
    RestClient.get(ENV['base_url'] + '/activity',:cookie => Request.create_cookie(cookies)){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
       puts Request.to_yaml
      return response
    }
  end

end
