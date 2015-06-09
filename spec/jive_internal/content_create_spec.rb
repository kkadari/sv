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

    RestClient.post('http://dev188.sure.vine/__services/v2/rest/discussion/',payload,{:cookie => @authorisation,:content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when creating a blog post' do
    payload = BlogPayload
                  .new('Testing blog 1',
                       'Content goes here',
                       'amber',
                       Hash[:type => 'community'],
                       'test1, test2, test3').payload

    RestClient.post('http://dev188.sure.vine/__services/v2/rest/blogPosts/',payload,{:cookie => @authorisation,:content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when creating a poll' do
    payload = PollPayload
                  .new(@authorisation,
                       'Testing poll 1',
                       'body content goes here',
                       'green',
                       'Information text ').payload

    RestClient.post('http://dev188.sure.vine/__services/v2/rest/polls',payload,{:cookie => @authorisation,:content_type => 'application/json; charset=UTF-8'}){|response|
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

    RestClient.post('http://dev188.sure.vine/__services/v2/rest/incidentReports/',payload,{:cookie => @authorisation,:content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when creating a document' do
    payload = DocumentPayload
                  .new('Testing document',
                       'body content here',
                       'red',
                       'test.jpg').payload

    RestClient.post('http://dev188.sure.vine/__services/v2/rest/document/upload',payload,{:cookie => @authorisation,:content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end