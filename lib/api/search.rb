class Search < Request

  def self.get_content_only_search(keyword, cookies)
    RestClient.get(ENV['base_url'] + '/api/core/v3/search/contents?collapse=true&fields=handlingLevel%2CrootType%2Ctype%2Csubject%2Cauthor%2Cquestion%2Canswer%2Chelpful%2CparentPlace%2CparentContent%2ChighlightSubject%2ChighlightBody%2ChighlightTags%2CoutcomeCounts%2Cpublished%2Cupdated%2CreplyCount%2ClikeCount%2CviewCount%2CvisibleToExternalContributors%2CbinaryURL%2CiconCss&directive=include_rtc&filter=search(' + keyword + ')',:cookie => Request.create_cookie(cookies)){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200

      return response
    }
  end

end