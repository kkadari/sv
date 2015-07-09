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

end