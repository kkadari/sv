require 'spec_helper'

# Create a message for use

describe 'Inbox page' do

  it 'should return a 200 when requesting the inbox page' do
    RestClient.get(ENV['base_url'] + '/inbox',:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when initialising the inbox view in activity' do

    puts "USER ID: " + @id
    puts "STREAM ID: " + @stream_id
    payload = '{"objectType":3,"objectID":"' + @id + '","streamSource":"communications","streamID":' + @stream_id + ',"filterType":[],"timestamp":0}'

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/activity-stream/initializeView',payload,{:cookie => @authorisation, :content_type => 'application/json', :accept => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when requesting messages' do
    payload = '{"objectType":3,"objectID":' + @id + ',"streamSource":"communications","streamID":' + @stream_id +',"filterType":["all"],"queryParam":null,"timestamp":"1434970679996"}'

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/activity-stream/list/before',payload,{:cookie => @authorisation, :content_type => 'application/json', :accept => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when requesting the activity stream list' do
    payload = '{"objectType":3,"objectID":' + @id + ',"streamSource":"communications","streamID":' + @stream_id +',"filterType":["all"],"queryParam":null,"timestamp":"1435067712220"}'

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/activity-stream/list',payload,{:cookie => @authorisation, :content_type => 'application/json', :accept => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 204 when requesting a different view for the inbox' do
    payload = 'split'

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/activity-stream/inbox/viewtype/save',payload,{:cookie => @authorisation, :content_type => 'application/json', :accept => 'application/json'}){|response|
      assert_code_and_body(response, 204)
    }
  end

  it 'should return a 204 when saving a differet list height' do
    RestClient.post(ENV['base_url'] + '/__services/v2/rest/activity-stream/inbox/listheight/save','284',{:cookie => @authorisation, :content_type => 'application/json', :accept => 'application/json'}){|response|
      assert_code_and_body(response, 204)
    }
  end

  it 'should return a 200 when requesting unread only messages' do
    RestClient.post(ENV['base_url'] + '/__services/v2/rest/activity-stream/activefilter/save/communications','unread',{:cookie => @authorisation, :content_type => 'application/json', :accept => 'application/json'}){|response|
      assert_code_and_body(response, 204)
    }
  end

  it 'should return a 204 when requesting all messages as read' do
    RestClient.post(ENV['base_url'] + '/__services/v2/rest/readtracking/markallread','1435068655395',{:cookie => @authorisation, :content_type => 'application/json', :accept => 'application/json'}){|response|
      assert_code_and_body(response, 204)
    }
  end

  it 'should return a 204 when pining inbox to the homeview' do
    RestClient.post(ENV['base_url'] + '/__services/v2/rest/stream-config/pinHomeNavView','jive-nav-link-communications',{:cookie => @authorisation, :content_type => 'application/json', :accept => 'application/json'}){|response|
      assert_code_and_body(response, 204)
    }
  end

  it 'should return a 204 when marking a message as unread' do
    RestClient.post(ENV['base_url'] + '/__services/v2/rest/readtracking/18/1833/unread',{:cookie => @authorisation, :content_type => 'application/json', :accept => 'application/json'}){|response|
      assert_code_and_body(response, 204)
    }
  end

  it 'should return a 204 when marking a message as read' do
    RestClient.post(ENV['base_url'] + '/__services/v2/rest/readtracking/18/1833/read',{:cookie => @authorisation, :content_type => 'application/json', :accept => 'application/json'}){|response|
      assert_code_and_body(response, 204)
    }
  end

  it 'should return a 200 when updating the active item ' do
    RestClient.post(ENV['base_url'] + '/__services/v2/rest/activity-stream/activeitem/save/102/1221',{:cookie => @authorisation, :content_type => 'application/json', :accept => 'application/json'}){|response|
      assert_code_and_body(response, 204)
    }
  end

  # Commenting out as this (appears to be) deprecated in Jive 8
  #it 'should return a 200 when following a message in inbox' do
  #  RestClient.post(ENV['base_url'] + '/__services/v2/rest/stream-config/11/objects','[{"objectType":102,"objectID":1221}]',{:cookie => @authorisation, :content_type => 'application/json', :accept => 'application/json'}){|response|
  #    assert_code_and_body(response, 200)
  #  }
  #end

  # Commenting out as this (appears to be) deprecated in Jive 8
  #it 'should return a 200 when stopping following a message in inbox' do
  #  RestClient.post(ENV['base_url'] + '/__services/v2/rest/stream-config/11/objects/remove','[{"objectType":102,"objectID":1221}]',{:cookie => @authorisation, :content_type => 'application/json', :accept => 'application/json'}){|response|
  #    assert_code_and_body(response, 200)
  #  }
  #end

  it 'should return a 200 when getting fullcontent of a message' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/activity-stream/fullcontent/102/1221',:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

end
