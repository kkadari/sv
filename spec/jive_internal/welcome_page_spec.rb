require 'spec_helper'

describe 'Welcome page' do

  it 'should return a 200 status code when requested' do
    RestClient.get(ENV['base_url'] + '/welcome',:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a redirect to the slideshow config which will then return a 200' do
    RestClient.get(ENV['base_url'] + '/slideshow-config',:cookie => @authorisation){|response|
      @location = response.headers[:location]
    }

    RestClient.get(ENV['base_url'] + '/' + @location,:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when getting the count for the activity stream' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/activity-stream/new/count',:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when calling the container security token' do
    timestamp = Time.now.to_i.to_s

    RestClient.get(ENV['base_url'] + '/__services/v2/rest/apps/v1/containersecuritytoken?_=' + timestamp,:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when getting additional browser events' do
    timestamp = Time.now.to_i.to_s

    RestClient.get(ENV['base_url'] + '/__services/v2/rest/browserEvents/' + timestamp + '?e=activityStream.poll', :cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

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

  it 'should return a 200 when requesting the different options for the whats happening service' do
    RestClient.get(ENV['base_url'] + '/whats-happening-ajax.jspa?containerType=14&provider=all', :cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }

    RestClient.get(ENV['base_url'] + '/whats-happening-ajax.jspa?containerType=14&provider=popular', :cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }

    RestClient.get(ENV['base_url'] + '/whats-happening-ajax.jspa?containerType=14&provider=following', :cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when calling the create menu widget' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/createmenu?containerType=14&containerID=1', :cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end