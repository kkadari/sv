class Places < Request

  def self.put_v3_group(id, payload, cookies)
    RestClient.put(ENV['base_url'] + '/api/core/v3/places/' + id, payload, {:cookie => Request.create_cookie(cookies), :content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200

      return response
    }
  end

  def self.post_delete_group(group_id, cookies)
    RestClient.get(ENV['base_url'] + '/groups/delete-group!input.jspa?socialGroup=' + group_id, :cookie => Request.create_cookie(cookies)){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200

      @token = Nokogiri::HTML.parse(response).css('input[name*="sgroup.delete"]')[0]['value']
    }

    payload = 'jive.token.name=sgroup.delete.' + group_id + '&sgroup.delete.' + group_id + '=' + @token + '&socialGroup=' + group_id

    RestClient.post(ENV['base_url'] + '/delete-group.jspa',payload, :cookie => Request.create_cookie(cookies)){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 302
    }
  end

  def self.get_places(cookies)
    RestClient.get(ENV['base_url'] + '/places', :cookie => Request.create_cookie(cookies)){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200

      return response
    }
  end

  def self.get_create_group(cookies)
    RestClient.get(ENV['base_url'] + '/edit-place.jspa?sr=cmenu&containerType=700', :cookie => Request.create_cookie(cookies)){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200

      return response
    }
  end

  def self.get_group(group_name, cookies)
    RestClient.get(ENV['base_url'] + '/groups/' + group_name,:cookie => Request.create_cookie(cookies)){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200

      return response
    }
  end

  def self.get_place_id(place_name, cookies)
    RestClient.get(ENV['base_url'] + '/api/core/v3/places?filter=search%28' + place_name + '%29', :cookie => Request.create_cookie(cookies)){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200

      return JSON.parse(response.split('.\';')[1])['list'][0]['id']
    }
  end

  def self.get_group_id(group_name, group_tag, cookies)
    RestClient.get(ENV['base_url'] + '/api/core/v3/places?filter=search(' + group_name + ')&filter=tag(' + group_tag + ')',:cookie => Request.create_cookie(cookies)){|response|

      fail('Failed with ' + response.code.to_s) if response.code != 200

      return JSON.parse(response.body.split('\';')[1])['list'][0]['id']
    }
  end

  def self.get_space_id(space_name, cookies)
    RestClient.get(ENV['base_url'] + '/api/core/v3/places?filter=search(' + space_name + ')&filter=type(space)',:cookie => Request.create_cookie(cookies)){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200

      return JSON.parse(response.body.split('\';')[1])['list'][0]['id']
    }
  end
end
