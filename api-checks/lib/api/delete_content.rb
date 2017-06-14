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

  def self.delete_discussion(doc_id, cookies)
    RestClient.get(ENV['base_url'] + '/thread-delete!input.jspa?message=' + doc_id,:cookie => Request.create_cookie(cookies)){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200

      @token = Nokogiri::HTML.parse(response).css('input[name*="thread.delete"]')[0]['value']
      @thread = Nokogiri::HTML.parse(response).css('input[name="thread"]')[0]['value']
      @message = Nokogiri::HTML.parse(response).css('input[name="message"]')[0]['value']
    }

    payload = DeleteDiscussionPayload.new(@thread, @message, @token).payload

    RestClient.post(ENV['base_url'] + '/thread-delete.jspa', payload, {:cookie => Request.create_cookie(cookies), :content_type => 'application/x-www-form-urlencoded'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 302
    }
  end

  def self.delete_ir(doc_id, cookies)
    RestClient.get(ENV['base_url'] + '/delete-incidentreport!input.jspa?incidentReportID=' + doc_id,:cookie => Request.create_cookie(cookies)){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200

      @token = Nokogiri::HTML.parse(response).css('input[name*="incidentReport.delete"]')[0]['value']
    }

    payload = DeleteIncidentReportPayload.new(doc_id, @token).payload

    RestClient.post(ENV['base_url'] + '/delete-incidentreport.jspa', payload, {:cookie => Request.create_cookie(cookies), :content_type => 'application/x-www-form-urlencoded'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 302
    }
  end

end
