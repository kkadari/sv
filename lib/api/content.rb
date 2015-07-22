class Content < Request

  def self.get_document(doc_id, cookies, status_code = 200)
    RestClient.get(ENV['base_url'] + '/docs/' + doc_id,:cookie => Request.create_cookie(cookies)){|response|
      fail('Failed with ' + response.code.to_s) if response.code != status_code

      return response
    }
  end

  def self.get_message(doc_id, cookies, status_code = 200)
    RestClient.get(ENV['base_url'] + '/message/' + doc_id,:cookie => Request.create_cookie(cookies)){|response|
      fail('Failed with ' + response.code.to_s) if response.code != status_code

      return response
    }
  end

  def self.get_blog(doc_id, cookies)
    RestClient.get(ENV['base_url'] + doc_id,{:cookie => Request.create_cookie(cookies),:content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200

      return response
    }
  end

  def self.get_ir(doc_id, cookies, status_code = 200)
    RestClient.get(ENV['base_url'] + '/incidentreports/' + doc_id,:cookie => Request.create_cookie(cookies)){|response|
      fail('Failed with ' + response.code.to_s) if response.code != status_code

      return response
    }
  end

end