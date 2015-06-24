require 'spec_helper'

describe 'View discussion page' do

  it 'should return a 200 when requested' do
    RestClient.get(ENV['base_url'] + '/thread/3041',{:cookie => @authorisation, :content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when requesting the PDF of the discussion' do
    RestClient.get(ENV['base_url'] + '/thread/3041.pdf',{:cookie => @authorisation, :content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when requesting a specific message in the discussion' do
    RestClient.get(ENV['base_url'] + '/message/3761',{:cookie => @authorisation, :content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when requesting inline comments for a discussion' do
    RestClient.get(ENV['base_url'] + '/inline-message.jspa?message=3806',{:cookie => @authorisation, :content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when requesting the report abuse popup' do
    RestClient.get(ENV['base_url'] + '/message-abuse!input.jspa?objectID=2986&objectType=1',{:cookie => @authorisation, :content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when reporting abuse' do
    payload = 'jive.token.name=message.abuse.1.2986&message.abuse.1.2986=1435137547868-A8GTQXDEMQPE134J3WGCOPFQV0ZYGTTL&objectID=2986&objectType=1&abuseType=9&comment=Ignore+this&report=Report+Abuse'

    RestClient.post(ENV['base_url'] + '/message-abuse.jspa',payload,{:cookie => @authorisation, :content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when requesting the lock popup' do
    RestClient.get(ENV['base_url'] + '/thread-lock!input.jspa?thread=3041',{:cookie => @authorisation, :content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 302 when locking the discussion' do
    RestClient.get(ENV['base_url'] + '/thread-lock.jspa?thread=3041&lock=Lock',{:cookie => @authorisation, :content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 302
    }
  end

  it 'should return a 302 when unlocking the discussion' do
    RestClient.get(ENV['base_url'] + '/thread-unlock.jspa?thread=3041&unlock=Unlock',{:cookie => @authorisation, :content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 302
    }
  end

end