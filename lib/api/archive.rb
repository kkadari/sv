class Archive < Request

  def self.post_archive_poll(poll_id, cookies)
    RestClient.post(ENV['base_url'] + '/__services/v2/rest/legacy_token/poll-archive-' + poll_id, '', :cookie => Request.create_cookie(cookies)){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200

      @token = JSON.parse(response)[0]
    }

    payload = 'jive.token.name=poll-archive-' + poll_id + '&poll-archive-' + poll_id + '=' + @token + '&poll=' + poll_id

    RestClient.post(ENV['base_url'] + '/poll-archive.jspa', payload, :cookie => Request.create_cookie(cookies)){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 302
    }
  end

end