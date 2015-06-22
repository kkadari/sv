require 'spec_helper'

describe 'Search page' do

  it 'should return a 200 when searching for content' do
    query_string = '?collapse=true' +
                   '&fields=handlingLevel%2CrootType%2Ctype%2Csubject%2Cauthor%2Cquestion%2Canswer%2Chelpful%2CparentPlace%2CparentContent%2ChighlightSubject%2ChighlightBody%2ChighlightTags%2CoutcomeCounts%2Cpublished%2Cupdated%2CreplyCount%2ClikeCount%2CviewCount%2CvisibleToExternalContributors%2CbinaryURL%2CiconCss' +
                   '&directive=include_rtc&filter=search(lorem)'

    RestClient.get(ENV['base_url'] + '/api/core/v3/search/contents' + query_string,:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when searching for people' do
    query_string = '?filter=search(stephanie)'

    RestClient.get(ENV['base_url'] + '/api/core/v3/search/people' + query_string,:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when searching for places' do
    query_string = '?filter=search(test)'

    RestClient.get(ENV['base_url'] + '/api/core/v3/search/places' + query_string,:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end