require 'spec_helper'

describe 'Creating content' do

  it 'should return a 200 when creating a discussion' do
    payload = DiscussionPayload
                  .new('Testing builder 2',
                       false,
                       'body content goes here',
                       'red',
                       Hash[:type => 'community'],
                       'test, test1',
                       false).payload

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/discussion/',payload,{:cookie => @authorisation,:content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when creating a blog post' do
    payload = BlogPayload
                  .new('Testing blog 1',
                       'Content goes here',
                       'amber',
                       'test1, test2, test3').payload

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/blogPosts/',payload,{:cookie => @authorisation,:content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when creating an incident report' do
    payload = IncidentReportPayload
                  .new('Testing builder 2',
                       false,
                       'body content goes here',
                       'red',
                       Hash[:type => 'community'],
                       'test, test2',
                       false).payload

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/incidentReports/',payload,{:cookie => @authorisation,:content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when creating a document' do
    payload = DocumentPayload
                  .new(Faker::Lorem.words(10).join(','),
                       'body content here',
                       'red',
                       'test.jpg').payload

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/document/upload',payload,{:cookie => @authorisation,:content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end


  it 'should return a 200 when requesting the create discussion page' do
    RestClient.get(ENV['base_url'] + '/discussion/create.jspa?sr=crmenu&containerType=-1&containerID=-1',:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when requesting the create blog post page' do
    RestClient.get(ENV['base_url'] + '/blog/create-post.jspa?sr=cmenu&containerType=14&containerID=1',:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when requesting the create incident report page' do
    RestClient.get(ENV['base_url'] + '/incidentreports/create-incidentreport.jspa!input?sr=crmenu&containerType=14&containerID=1',:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when requesting the create document page' do
    RestClient.get(ENV['base_url'] + '/document/upload.jspa?sr=crmenu&containerType=14&containerID=1',:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end