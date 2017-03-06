class DocumentVersion < Request

  def self.post_switch_version(doc_id, version, cookies)
    RestClient.get(ENV['base_url'] + '/docs/' + doc_id + '/version',:cookie => Request.create_cookie(cookies)){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200

      @token = Nokogiri::HTML.parse(response).css('input[name*="document.restore."]')[0]['value']
    }

    payload = 'version=' + version + '&jive.token.name=document.restore.' + doc_id + '&document.restore.' + doc_id + '=' + @token

    RestClient.post(ENV['base_url'] + '/docs/' + doc_id + '/restore', payload, {:cookie => Request.create_cookie(cookies), :content_type => 'application/x-www-form-urlencoded'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 302
    }

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/legacy_token/document.publish.' + doc_id, '', {:cookie => Request.create_cookie(cookies), :accept => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200

      @token_2 = JSON.parse(response)[0]
    }

    payload2 = 'jive.token.name=document.publish.' + doc_id + '&document.publish.' + doc_id + '=' + @token_2 + '&document=' + doc_id

    RestClient.post(ENV['base_url'] + '/doc-publish.jspa', payload2, {:cookie => Request.create_cookie(cookies), :content_type => 'application/x-www-form-urlencoded'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 302
    }
  end

end
