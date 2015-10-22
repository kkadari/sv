class EditContent < Request

  def self.post_edit_document(doc_id, payload, cookies)
    RestClient.post(ENV['base_url'] + '/__services/v2/rest/legacy_token/jive.token.content.document.editUpload', :cookie => Request.create_cookie(cookies)){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200

      @token = JSON.parse(response)[0]
    }

    payload['jive.token.content.document.editUpload'] = @token

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/document/upload/' + doc_id.gsub('DOC-',''), payload, :cookie => Request.create_cookie(cookies)){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  def self.get_edit_ir(doc_id, cookies)
    RestClient.get(ENV['base_url'] + '/incidentreports/' + doc_id + '/edit', :cookie => Request.create_cookie(cookies)){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200

      return response
    }
  end

  def self.put_edit_ir(doc_id, payload, cookies)
    RestClient.put(ENV['base_url'] + '/__services/v2/rest/incidentReports/' + doc_id, payload,{:cookie => Request.create_cookie(cookies), :content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  def self.get_edit_message(discussion_id, cookies)
    RestClient.get(ENV['base_url'] + '/message/' + discussion_id + '/edit', :cookie => Request.create_cookie(cookies)){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200

      return response
    }
  end

  def self.put_edit_message(thread_id, payload, cookies)
    RestClient.put(ENV['base_url'] + '/__services/v2/rest/discussion/' + thread_id, payload, {:cookie => Request.create_cookie(cookies), :content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  def self.get_edit_poll(poll_id, cookies)
    RestClient.get(ENV['base_url'] + '/poll/edit.jspa?ID=' + poll_id, :cookie => Request.create_cookie(cookies)){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200

      return response
    }
  end

  def self.put_edit_poll(poll_id, payload, cookies)
    RestClient.put(ENV['base_url'] + '/__services/v2/rest/polls/' + poll_id, payload, {:cookie => Request.create_cookie(cookies), :content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end
