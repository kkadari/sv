require 'spec_helper'

describe 'Vote comment widget' do
# Based on /blogs/hero-banner/2016/02/24/hero-banner-config

  it 'should return a 200 when voting on a comment' do
    payload = 'ratingType=like&voteValue=1'

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/acclaim/38/1043/addvote',payload,:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when de-voting on a comment' do
    payload = 'ratingType=like'

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/acclaim/38/1043/removevote',payload,:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

end
