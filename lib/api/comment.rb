class Comment < Request

  def self.post_ir_comment(ir_id, payload, cookies)
    RestClient.post(ENV['base_url'] + '/__services/v2/rest/comments/11111/' + ir_id,payload,{:cookie => Request.create_cookie(cookies), :content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  def self.get_ir_comments(ir_id, cookies)
    RestClient.get(ENV['base_url'] + '/comment-list.jspa?location=jive-comments&mode=comments&isPrintPreview=false&object=' + ir_id + '&contentObjectType=11111&start=0&numResults=25',{:cookie => Request.create_cookie(cookies), :x_requested_with => 'XMLHttpRequest'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200

      return response
    }
  end

  def self.post_blog_comment(blog_id, payload, cookies)
    RestClient.post(ENV['base_url'] + '/__services/v2/rest/comments/38/' + blog_id,payload,{:cookie => Request.create_cookie(cookies),:content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200

      @blog_url = JSON.parse(response)['redirect']
    }
  end

  def self.get_blog_comments(blog_id, cookies)
    RestClient.get(ENV['base_url'] + '/comment-list.jspa?location=jive-comments&mode=comments&isPrintPreview=false&object=' + blog_id + '&contentObjectType=38&start=0&numResults=25&sort=datedesc',{:cookie => Request.create_cookie(cookies),:x_requested_with => 'XMLHttpRequest',:content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200

      return response
    }
  end

  def self.get_advanced_comment_editor(id, cookies)
    RestClient.post(ENV['base_url'] + '/create-advanced-comment.jspa','id=' + id,{:cookie => Request.create_cookie(cookies),:content_type => 'application/x-www-form-urlencoded'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  def self.post_advanced_comment_editor(payload, cookies)
    RestClient.post(ENV['base_url'] + '/__services/v2/rest/advancedComment', payload, {:cookie => Request.create_cookie(cookies),:content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  def self.post_document_comment(id, payload, cookies)
    RestClient.post(ENV['base_url'] + '/__services/v2/rest/comments/102/' + id,payload,{:cookie => Request.create_cookie(cookies),:content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  def self.get_document_comments(id, cookies)
    RestClient.get(ENV['base_url'] + '/doc-comments.jspa?location=jive-comments&mode=comments&isPrintPreview=false&document=' + id + '&version=1&start=0&numResults=25&sort=datedesc',{:cookie => Request.create_cookie(cookies),:x_requested_with => 'XMLHttpRequest',:content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200

      return response
    }
  end

  def self.post_update_comment(id, payload, cookies)
    RestClient.post(ENV['base_url'] + '/__services/v2/rest/comments/' + id,payload,{:cookie => Request.create_cookie(cookies),:content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  def self.post_message_comment(thread_id, message_id, payload, cookies)
    RestClient.post(ENV['base_url'] + '/__services/v2/rest/message/' + thread_id + '/' + message_id, payload, {:cookie => Request.create_cookie(cookies),:content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end
