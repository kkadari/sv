class CreateContent < Request

  def self.create_incident_report(payload, cookies)
    RestClient.post(ENV['base_url'] + '/__services/v2/rest/incidentReports/',payload,{:cookie => create_cookie(cookies),:content_type => 'application/json'}){|response|
      raise 'Could not create incident report' if response.body.include? 'You are not allowed to create or update this content' || response.code != 200

      JSON.parse(response.body)
    }
  end

  # Allows you to create a discussion via the REST endpoint
  # Params:
  # +cookies+:: Array<Hash> - Expects an array of cookies that can be taken from an active WebDriver session using @browser.cookies.to_a
  # +subject+:: String - Expects a standard string to set the subject of the discussion
  # +question+::  Boolean - Expects a boolean flag to set whether the discussion will be anonymous or not
  # +body+:: String - Expects a standard string (which may include html tags) and will wrap them in <body><p></p></body> to form the body of the discussion
  # +handling_level+:: String - Expects a string that is converted into a number.  Allowed combinations are red, amber, green, white and random.
  # +publication+:: Hash - Expects one of three different types to set who to publish the discussion to.  They are:
  #                        Community, Private group, Secret group = Hash[:type => 'community']
  #                        Space                                  = Hash[:type => 'space',:users => 'user1@test,user2@test'] - Note that each user you want is comma separated
  # +tags+:: String - Expects a standard string to create tags.  To create more than one tag they should be comma separated
  # +anonymous_flag+:: Boolean - Expects a boolean flag to set whether the report will be anonymous or not
  def self.create_discussion(cookies,subject,question,body,handling_level,publication,tags,anonymous_flag)
    payload = DiscussionPayload.new(subject,question,body,handling_level,publication,tags,anonymous_flag).payload

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

  def self.post_create_poll(payload, cookies)
    RestClient.post(ENV['base_url'] + '/__services/v2/rest/polls',payload,{:cookie => Request.create_cookie(cookies),:content_type => 'application/json; charset=UTF-8'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end