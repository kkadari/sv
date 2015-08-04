class CreateContent < Request

  def self.create_incident_report(payload, cookies)
    RestClient.post(ENV['base_url'] + '/__services/v2/rest/incidentReports/',payload,{:cookie => create_cookie(cookies),:content_type => 'application/json'}){|response|
      raise 'Could not create incident report' if response.body.include? 'You are not allowed to create or update this content' || response.code != 200

      JSON.parse(response.body)
    }
  end

  def self.create_discussion(payload, cookies)
    RestClient.post(ENV['base_url'] + '/__services/v2/rest/discussion', payload,{:cookie => create_cookie(cookies),:content_type => 'application/json'}){|response|
      raise 'Could not create discussion' if response.body.include? 'You are not allowed to create or update this content' || response.code != 200

      JSON.parse(response.body)
    }
  end

  def self.post_document(payload, cookies)
    RestClient.post(ENV['base_url'] + '/__services/v2/rest/document/upload',payload,{:cookie => Request.create_cookie(cookies),:content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200

      return response
    }
  end

  def self.post_blog(payload, cookies)
    RestClient.post(ENV['base_url'] + '/__services/v2/rest/blogPosts/',payload,{:cookie => Request.create_cookie(cookies),:content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200

      return response
    }
  end

  def self.get_create_poll(cookies)
    RestClient.get(ENV['base_url'] + '/poll/create.jspa?sr=cmenu&containerType=2020&containerID=1024',:cookie => Request.create_cookie(cookies)){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200

      return response
    }
  end

  def self.get_poll_choice(poll_id, cookies)
    RestClient.post(ENV['base_url'] + '/__services/v2/rest/polls/' + poll_id + '/pollOptions','',:cookie => Request.create_cookie(cookies)){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200

      return response
    }
  end

  def self.post_create_poll(payload, cookies)
    RestClient.post(ENV['base_url'] + '/__services/v2/rest/polls',payload,{:cookie => Request.create_cookie(cookies),:content_type => 'application/json; charset=UTF-8'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200

      return response
    }
  end

end