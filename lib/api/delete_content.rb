class DeleteContent < Request

  def self.delete_document(doc_id, cookies)
    RestClient.post(ENV['base_url'] + '/__services/v2/rest/legacy_token/document.delete.' + doc_id,'',:cookie => Request.create_cookie(cookies)){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200

      @token = JSON.parse(response)[0]
    }

    payload = DeleteDocumentPayload.new(doc_id, @token).payload

    RestClient.post(ENV['base_url'] + '/docs/' + doc_id + '/delete', payload, {:cookie => Request.create_cookie(cookies), :accept => 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8', :content_type => 'application/x-www-form-urlencoded'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 302
    }
  end

end