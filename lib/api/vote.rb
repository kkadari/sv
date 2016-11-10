class Vote < Request

  def self.post_vote(poll_id, payload, cookies)  # Not working yet.
    RestClient.post(ENV['base_url'] + '/__services/v2/rest/polls/'+ poll_id +'/votes',payload,{:cookie => Request.create_cookie(cookies), 'X-Requested-With' =>'XMLHttpRequest'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end
