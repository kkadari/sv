class Follow < Request

  def self.delete_follow_connection_v3(user_1_id, user_2_id, cookies)
    RestClient.delete(ENV['base_url'] + '/api/core/v3/people/' + user_1_id + '/@following/' + user_2_id, :cookie => Request.create_cookie(cookies)){|response|
      if response.code != 204 && response.code != 409
        fail('Failed with ' + response.code.to_s)
      end
    }
  end

  def self.post_follow_request(payload, cookies)
    RestClient.post(ENV['base_url'] + '/__services/v2/rest/stream-config/user/associations/manage', payload, {:cookie => Request.create_cookie(cookies), :content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  def self.post_action_follow_request(payload, cookies)
    RestClient.post(ENV['base_url'] + '/__services/v2/rest/action-queue/performAction', payload, {:cookie => Request.create_cookie(cookies), :content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  def self.delete_follow_connection(user_id, cookies)
    RestClient.delete(ENV['base_url'] + '/__services/v2/rest/stream-config/3/' + user_id, {:cookie => Request.create_cookie(cookies), :content_type => 'text/plain'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 204
    }
  end

  def self.post_follow_group(group_id, cookies)
    payload = '[{"objectType":"14","objectID":"' + group_id + '"}]'

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/stream-config/user/associations/manage', payload, {:cookie => Request.create_cookie(cookies), :content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end
