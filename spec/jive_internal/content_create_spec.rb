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
    payload = '{
      "subject":"Blog - Spec test 1",
      "body":"<body><p>body content goes here</p></body>",
      "handlingLevel":"2",
      "publishBar":{
        "visibility":"all",
        "container":{
          "objectType":"37",
          "objectID":"1016"
        },
      "commentStatus":"2",
      "blogPublishOption":false,
      "publishDate":{
          "selectedDate":"6/9/2015",
          "selectedHour":"1",
          "selectedMinute":"0",
          "selectedPeriod":"AM"
        }
      },
      "tags":"tag1,tag2,tag3",
      "jiveTokenName":"jive.token.content.blogpost.create"
    }'

    RestClient.post('http://dev188.sure.vine/__services/v2/rest/blogPosts/',payload,{:cookie => @authorisation,:content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when creating a poll' do
    RestClient.get('http://dev188.sure.vine/poll/create.jspa?sr=cmenu&containerType=2020&containerID=1024',:cookie => @authorisation){|response|
      @poll_id = response.body.scan(/name="pollID" value="([0-9]*)/).join(",")
    }

    RestClient.post('http://dev188.sure.vine/__services/v2/rest/polls/' + @poll_id + '/pollOptions','',:cookie => @authorisation){|response|
      @choice = response.body.scan(/"id" : ([0-9]*)\n/).join(",").to_i - 2
    }

    @options = ''

    2.times do |t|
      @options += '{
          "text": "Choice ' + t.to_s + '",
          "ID": "' + (@choice - t).to_s + '",
          "index": "' + t.to_s + '"
      },'
    end

    payload = '{
      "pollID": "' + @poll_id + '",
      "voteCount": "0",
      "subject": "Poll - Spec test 2",
      "body": "<body><p>Details here     </p></body>",
      "options": [' + @options[0...-1] + '
      ],
      "handlingLevel": "2",
      "publishBar": {
          "visibility": "all",
          "pollVoteOptions": false
      },
      "activeMode": "activenow",
      "endsMode": "endsnever",
      "endsDays": "14",
      "jiveTokenName": "jive.token.content.poll.create"
    }'

    RestClient.post('http://dev188.sure.vine/__services/v2/rest/polls',payload,{:cookie => @authorisation,:content_type => 'application/json; charset=UTF-8'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when creating an incident report' do
    payload = IncidentReportPayload.new('Testing builder 2',
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
    payload = {
        :subject => 'test.jpg',
        :body => '<body><p>Description here</p></body>',
        :handlingLevel => '2',
        'publishBar.visibility' => 'all',
        'publishBar.defaultAuthorshipPolicy' => '2',
        'publishBar.commentStatus' => '2',
        :uploadFile => File.new(File.dirname(__FILE__) + '/../../bin/test.jpg'),
        :multipart  => true
    }

    RestClient.post('http://dev188.sure.vine/__services/v2/rest/document/upload',payload,{:cookie => @authorisation,:content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end