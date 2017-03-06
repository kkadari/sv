class Inbox < Request

  def self.get_connections_inbox_message(cookies)
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/action-queue/list?categoryID=1002&type=active&numResults=1', {:cookie => Request.create_cookie(cookies), :content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200

      return response
    }
  end

  def self.get_inbox(cookies)
    RestClient.get(ENV['base_url'] + '/inbox', {:cookie => Request.create_cookie(cookies), :content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200

      return response
    }
  end

  def self.post_for_message(msg_id, payload, cookies)
    RestClient.post(ENV['base_url'] + '/__services/v2/rest/activity-stream/fullreplies/11111/' + msg_id, payload, {:cookie => Request.create_cookie(cookies), :content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200

      return response
    }
  end

end
