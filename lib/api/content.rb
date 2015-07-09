class Content < Request

  def self.get_document(doc_id, cookies, status_code = 200)
    RestClient.get(ENV['base_url'] + '/docs/' + doc_id,:cookie => Request.create_cookie(cookies)){|response|
      fail('Failed with ' + response.code.to_s) if response.code != status_code
    }
  end

  def self.get_message(doc_id, cookies, status_code = 200)
    RestClient.get(ENV['base_url'] + '/message/' + doc_id,:cookie => Request.create_cookie(cookies)){|response|
      fail('Failed with ' + response.code.to_s) if response.code != status_code
    }
  end

end