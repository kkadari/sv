require 'spec_helper'

describe 'Viewing content' do

  it 'should return 200 when viewing a Discussion' do
    payload = DiscussionPayload
                  .new(Faker::Lorem.sentence(3),
                       false,
                       Faker::Lorem.sentence(20),
                       'random',
                       Hash[:type => 'community'],
                       '',
                       false).payload

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/discussion/',payload,{:cookie => @authorisation,:content_type => 'application/json'}){|response|
      @payload = JSON.parse(response.body)
    }

    RestClient.get(ENV['base_url'] + '/' + @payload['redirect'],:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when viewing a blog post' do
    RestClient.proxy = 'http://127.0.0.1:8080'

    payload = BlogPayload
                  .new(Faker::Lorem.sentence(3),
                       Faker::Lorem.sentence(20),
                       'random',
                       Hash[:type => 'community'],
                       'test1, test2, test3').payload

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/blogPosts/',payload,{:cookie => @authorisation,:content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
      @payload = JSON.parse(response.body)
    }

    RestClient.get(ENV['base_url'] + '/' + @payload['redirect'],:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when viewing a poll' do
    payload = PollPayload
                  .new(@authorisation,
                       Faker::Lorem.sentence(3),
                       Faker::Lorem.sentence(20),
                       'random',
                       Faker::Lorem.words(2).join(',')).payload

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/polls',payload,{:cookie => @authorisation,:content_type => 'application/json; charset=UTF-8'}){|response|
      @payload = JSON.parse(response.body)
    }

    RestClient.get(ENV['base_url'] + '/' + @payload['redirect'],:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return 200 when viewing a Incident Report' do
    payload = IncidentReportPayload
                  .new(Faker::Lorem.sentence(3),
                       false,
                       Faker::Lorem.sentence(20),
                       'random',
                       Hash[:type => 'community'],
                       '',
                       false).payload

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/incidentReports/',payload,{:cookie => @authorisation,:content_type => 'application/json'}){|response|
      @payload = JSON.parse(response.body)
    }

    RestClient.get(ENV['base_url'] + '/' + @payload['redirect'],:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when viewing a document' do
    payload = DocumentPayload
                  .new(Faker::Lorem.sentence(3),
                       Faker::Lorem.sentence(20),
                       'random',
                       'test.jpg').payload

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/document/upload',payload,{:cookie => @authorisation,:content_type => 'application/json'}){|response|
      @payload = JSON.parse(response.body.scan(/{.*}/)[0])
    }

    RestClient.get(ENV['base_url'] + '/' + @payload['redirect'],:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end