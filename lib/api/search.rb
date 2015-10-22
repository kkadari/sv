class Search < Request

  def self.get_content_only_search(keyword, cookies)
    RestClient.get(ENV['base_url'] + '/api/core/v3/search/contents?collapse=true&fields=handlingLevel%2CrootType%2Ctype%2Csubject%2Cauthor%2Cquestion%2Canswer%2Chelpful%2CparentPlace%2CparentContent%2ChighlightSubject%2ChighlightBody%2ChighlightTags%2CoutcomeCounts%2Cpublished%2Cupdated%2CreplyCount%2ClikeCount%2CviewCount%2CvisibleToExternalContributors%2CbinaryURL%2CiconCss&directive=include_rtc&filter=search(' + keyword + ')',:cookie => Request.create_cookie(cookies)){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200

      return response
    }
  end

  def self.get_spotlight_content(keyword, cookies)
    RestClient.get(ENV['base_url'] + '/api/core/v3/search/contents?sort=relevanceDesc&origin=spotlight&highlight=false&count=10&filter=search(' + keyword + '*)&fields=type%2Cid%2Cauthor%2Csubject%2CvisibleToExternalContributors%2Cpublished%2Cupdated%2Cquestion%2Canswer%2Chelpful&collapse=true&directive=include_rtc', {:cookie => Request.create_cookie(cookies),:content_type => 'application/json'}){|response|
      raise 'Could not create discussion' if response.code != 200

      return response
    }
  end

  def self.get_spotlight_people(keyword, cookies)
    RestClient.get(ENV['base_url'] + '/api/core/v3/search/people?sort=relevanceDesc&origin=spotlight&highlight=false&count=10&filter=search(' + keyword + '*)&fields=type%2Cid%2Cname%2CdisplayName%2CthumbnailId%2Cjive', {:cookie => Request.create_cookie(cookies),:content_type => 'application/json'}){|response|
      raise 'Could not create discussion' if response.code != 200

      return response
    }
  end

end
