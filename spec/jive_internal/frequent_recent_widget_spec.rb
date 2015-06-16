require 'spec_helper'

describe 'Frequent and recent widget' do

  it 'should return a 200 when requesting frequently viewed search details' do
    RestClient.get(ENV['base_url'] + '/api/core/v3/activities/frequent/content?count=10&fields=type%2Cid%2Cauthor%2Csubject%2CvisibleToExternalContributors%2Cpublished%2Cupdated%2Cquestion%2Canswer%2Chelpful', :cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }

    RestClient.get(ENV['base_url'] + '/api/core/v3/activities/frequent/people?count=10&fields=type%2Cid%2Cauthor%2Csubject%2CvisibleToExternalContributors%2Cpublished%2Cupdated%2Cquestion%2Canswer%2Chelpful', :cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }

    RestClient.get(ENV['base_url'] + '/api/core/v3/activities/frequent/places?count=10&fields=type%2Cid%2Cauthor%2Csubject%2CvisibleToExternalContributors%2Cpublished%2Cupdated%2Cquestion%2Canswer%2Chelpful', :cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when requesting recently viewed search details' do
    RestClient.get(ENV['base_url'] + '/api/core/v3/activities/recent/content?count=10&fields=type%2Cid%2Cauthor%2Csubject%2CvisibleToExternalContributors%2Cpublished%2Cupdated%2Cquestion%2Canswer%2Chelpful', :cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }

    RestClient.get(ENV['base_url'] + '/api/core/v3/activities/recent/people?count=10&fields=type%2Cid%2Cauthor%2Csubject%2CvisibleToExternalContributors%2Cpublished%2Cupdated%2Cquestion%2Canswer%2Chelpful', :cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }

    RestClient.get(ENV['base_url'] + '/api/core/v3/activities/recent/places?count=10&fields=type%2Cid%2Cauthor%2Csubject%2CvisibleToExternalContributors%2Cpublished%2Cupdated%2Cquestion%2Canswer%2Chelpful', :cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end