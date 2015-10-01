require 'spec_helper'

describe 'View discussion page' do

  before(:all) do
    payload = DiscussionPayload
                  .new('View discussion page test',
                       false,
                       'body content goes here',
                       'red',
                       Hash[:type => 'community'],
                       'test, test1',
                       false).payload

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/discussion/',payload,{:cookie => @authorisation,:content_type => 'application/json'}){|response|
      @redirect = JSON.parse(response.body)['redirect']
      @message_id = response.body.scan(/message\/[0-9]*/)[0].split('/')[1]
    }

    RestClient.get(ENV['base_url'] + @redirect,:cookie => @authorisation){|response|
      @msg_id = response.body().scan(/canonical" href="[\/a-z0-9]*/)[0].split('thread/')[1]
    }
  end

  it 'should return a 200 when requested' do
    RestClient.get(ENV['base_url'] + '/thread/' + @msg_id,{:cookie => @authorisation, :content_type => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when requesting the PDF of the discussion' do
    RestClient.get(ENV['base_url'] + '/thread/' + @msg_id + '.pdf',{:cookie => @authorisation, :content_type => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when requesting a specific message in the discussion' do
    RestClient.get(ENV['base_url'] + '/message/' + @message_id,{:cookie => @authorisation, :content_type => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when requesting inline comments for a discussion' do
    RestClient.get(ENV['base_url'] + '/inline-message.jspa?message=' + @message_id,{:cookie => @authorisation, :content_type => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when requesting the report abuse popup' do
    RestClient.get(ENV['base_url'] + '/message-abuse!input.jspa?objectID=2986&objectType=1',{:cookie => @authorisation, :content_type => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when reporting abuse' do
    payload = 'jive.token.name=message.abuse.1.2986&message.abuse.1.2986=1435137547868-A8GTQXDEMQPE134J3WGCOPFQV0ZYGTTL&objectID=2986&objectType=1&abuseType=9&comment=Ignore+this&report=Report+Abuse'

    RestClient.post(ENV['base_url'] + '/message-abuse.jspa',payload,{:cookie => @authorisation, :content_type => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when requesting the lock popup' do
    RestClient.get(ENV['base_url'] + '/thread-lock!input.jspa?thread=' + @msg_id,{:cookie => @authorisation, :content_type => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 302 when locking the discussion' do
    RestClient.get(ENV['base_url'] + '/thread-lock.jspa?thread=' + @msg_id + '&lock=Lock',{:cookie => @authorisation, :content_type => 'application/json'}){|response|
      assert_code_and_body(response, 302)
    }
  end

  it 'should return a 302 when unlocking the discussion' do
    sleep 2 # We wait a couple of seconds to allow Jive to catch up with locking the thread otherwise the test fails - MW

    RestClient.get(ENV['base_url'] + '/thread-unlock.jspa?thread=' + @msg_id + '&unlock=Unlock',{:cookie => @authorisation, :content_type => 'application/json'}){|response|
      assert_code_and_body(response, 302)
    }
  end

end