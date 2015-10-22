class Vote < Request

  def self.post_vote(poll_id, payload, cookies)
    RestClient.post(ENV['base_url'] + '/__services/v2/rest/acclaim/2/' + poll_id + '/addvote',payload,:cookie => Request.create_cookie(cookies)){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end
