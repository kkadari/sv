class Rating < Request

  def self.post_ir_rating(ir_id, score, cookies)
    RestClient.post(ENV['base_url'] + '/__services/v2/rest/rating/11111/' + ir_id,'score=' + score,:cookie => Request.create_cookie(cookies)){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  def self.get_ir_rating(ir_id, cookies)
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/rating/11111/' + ir_id,:cookie => Request.create_cookie(cookies)){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200

      return response
    }
  end

end
