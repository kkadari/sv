class Inbox < Request

  def self.get_connections_inbox_message(cookies)
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/action-queue/list?categoryID=1002&type=active&numResults=1', {:cookie => Request.create_cookie(cookies), :content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200

      return response
    }
  end

end