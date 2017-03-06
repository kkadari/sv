require 'spec_helper'

describe 'Search page' do

  it 'should return a 200 when searching for content' do
    query_string = '?collapse=true' +
                   '&fields=handlingLevel' +
                   '&directive=include_rtc&filter=search(lorem)'

    RestClient.get(ENV['base_url'] + '/api/core/v3/search/contents' + query_string,:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when searching for people' do
    query_string = '?filter=search(' + ENV['username'] + ')'

    RestClient.get(ENV['base_url'] + '/api/core/v3/search/people' + query_string,:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when searching for places' do
    query_string = '?filter=search(test)'

    RestClient.get(ENV['base_url'] + '/api/core/v3/search/places' + query_string,:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

end
