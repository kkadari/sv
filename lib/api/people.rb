class People < Request

  def self.get_browse_people(cookies)
    RestClient.get(ENV['base_url'] + '/people?filterID=all',:cookie => Request.create_cookie(cookies)){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  def self.get_browse_people_by_skill_all(user_id, cookies)
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/users/' + user_id + '/browse?filterGroupID=people&itemViewID=detail&start=0&numResults=20&filterID=all~skill&itemView=detail&userID=' + user_id,:cookie => Request.create_cookie(cookies)){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  def self.get_browse_people_by_organisation_all(user_id, cookies)
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/users/' + user_id + '/browse?filterGroupID=people&itemViewID=detail&start=0&numResults=20&filterID=all~profile%5Borganisation%5D&itemView=detail&userID=' + user_id,:cookie => Request.create_cookie(cookies)){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  def self.get_browse_people_by_specific_organisation(user_id, organisation, cookies)
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/users/' + user_id + '/browse?filterGroupID=people&itemViewID=detail&start=0&numResults=20&filterID=all~profile%5Borganisation%5D~organisation%5B' + organisation + '%5D&itemView=detail&userID=' + user_id,:cookie => Request.create_cookie(cookies)){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200

      return response
    }
  end

end


