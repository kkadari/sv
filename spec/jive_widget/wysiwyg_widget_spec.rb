require 'spec_helper'

describe 'WYSIWYG editor' do

  it 'should return a 200 when the content picker for links is requested' do
    RestClient.get(ENV['base_url'] + '/content-picker!input.jspa?name=&instantiatedFromGUIEditor=true',:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when the image picker for embeds is requested' do
    RestClient.get(ENV['base_url'] + '/rte-image-modal.jspa',:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when the spell checker is sent a payload to verify' do
    payload = '{"id":"c0","method":"checkWords","params":["en_us",["test","content"]]}'

    RestClient.post(ENV['base_url'] + '/spellcheck.jspa',payload,{:cookie => @authorisation,:content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when calling the details of a mention added in the editor' do
    path = '/__services/v2/rest/emention/restrictedView?editingObjectID=1006&editingObjectType=2020&entitlement=VIEW_CONTENT&mentionedObjectType=3&mentionedObjectID=2024'

    RestClient.get(ENV['base_url'] + path,:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when uploading an image to embed in the content' do
    upload_file = File.new(File.dirname(__FILE__) + '/../../bin/test.jpg')
    payload = {
        :dummyValue => 'dummy',
        'jive.token.name' => 'rte.image.token',
        :objectId => '-1',
        :objectType => '2',
        :imageFile => upload_file,
        :multipart  => true
    }

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/rteImages',payload,{:cookie => @authorisation,:content_type => 'multipart/form-data'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when creating a new instance of the editor to reply to content' do
    path = '/__services/v2/rest/rteImages/settings?objectId=-1&objectType=-1&containerId=1006&containerType=2020'

    RestClient.get(ENV['base_url'] + path,:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when calling the AutoTitle endpoint' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/rteLinks?href=http%3A%2F%2Fgoogle.com',:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end
end