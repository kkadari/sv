require 'spec_helper'

describe 'Vote comment widget' do

  it 'should return a 200 when voting on a comment' do
    payload = 'ratingType=like&voteValue=1'

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/acclaim/2/3611/addvote',payload,:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when de-voting on a comment' do
    payload = 'ratingType=like'

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/acclaim/2/3611/removevote',payload,:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end