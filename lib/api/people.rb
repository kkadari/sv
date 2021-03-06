class People < Request

  def self.post_set_grid_view(cookies)
    RestClient.post(ENV['base_url'] + '/__services/v2/rest/users/current/prop/browse.people.itemviewtoggle','detail',{:cookie => Request.create_cookie(cookies), :content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 204
    }
  end

  def self.get_browse_people(cookies)
    RestClient.get(ENV['base_url'] + '/people?filterID=all',:cookie => Request.create_cookie(cookies)){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200

      return response
    }
  end

  def self.get_browse_people_by_skill_all(user_id, cookies)
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/users/' + user_id + '/browse?filterGroupID=people&itemViewID=detail&start=0&numResults=20&filterID=all~skill&itemView=detail&userID=' + user_id,:cookie => Request.create_cookie(cookies)){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  def self.get_order_by_date(cookies)
    RestClient.get(ENV['base_url'] + '/people?filterID=all&sortKey=all~lastLoggedInDesc&sortOrder=0',:cookie => Request.create_cookie(cookies)){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200

      return response
    }
  end

  def self.order_by_organisation_all(user_id, cookies)
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/users/' + user_id + '/browse?filterGroupID=people&itemViewID=detail&start=0&numResults=20&filterID=all~profile%5Borganisation%5D&itemView=detail&userID=' + user_id,:cookie => Request.create_cookie(cookies)){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  def self.order_by_specific_organisation(user_id, organisation, cookies)
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/users/' + user_id + '/browse?filterGroupID=people&itemViewID=detail&start=0&numResults=20&filterID=all~profile%5Borganisation%5D~organisation%5B' + organisation + '%5D&itemView=detail&userID=' + user_id,:cookie => Request.create_cookie(cookies)){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200

      return response
    }
  end

  def self.get_people_page(username, cookies, status_code = 200)
    RestClient.get(ENV['base_url'] + '/people/' + username,{:cookie => Request.create_cookie(cookies), :content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != status_code

      return response
    }
  end

  def self.get_people_activity(username, cookies)
    RestClient.get(ENV['base_url'] + '/people/' + username + '/activity',{:cookie => Request.create_cookie(cookies), :content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200

      return response
    }
  end

  def self.post_ir_activity_comments(incident_id, cookies)
    payload ='{"originalIDs":[],"timestamp":0,"fullContent":true,"pageSize":5}'

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/activity-stream/fillinthegaps/11111/' + incident_id, payload, {:cookie => Request.create_cookie(cookies), :content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200

      return response
    }
  end

  def self.create_new_user(username, password, email, first_name, last_name)
    payload = '{
        "emails" : [ {
            "value" : "' + email + '",
            "type" : "work",
            "primary" : true,
            "jive_label" : "Email"
        } ],
        "jive" : {
            "password" : "' + password + '",
            "username" : "' + username + '"
        },
        "name" : {
            "familyName" : "' + last_name + '",
            "givenName" : "' + first_name + '"
        }
    }'

    RestClient.post(ENV['base_url'] + '/api/core/v3/people', payload, {:cookie => @authorisation, :content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 401
      return response
    }
  end

  def self.accept_terms(userid, cookies)
    RestClient.post(ENV['base_url'] + '/people/' + userid + '/acceptTermsAndConditions',{:cookie => @authorisation, :content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end
