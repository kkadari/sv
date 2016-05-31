require 'spec_helper'

describe 'Request a group widget' do

  it 'should return a 200 when requesting the widget app' do
    payload = '[{"method":"gadgets.metadata","id":"gadgets.metadata","params":{"container":"default","ids":["http://localhost:8080/resources/grouprequestapp/app.xml"],"fields":["iframeUrls","modulePrefs.*","needsTokenRefresh","userPrefs.*","views.preferredHeight","views.preferredWidth","expireTimeMs","responseTimeMs","rpcServiceIds","tokenTTL"],"language":"en","country":"US","userId":"@viewer","groupId":"@self"}}]'

    RestClient.post(ENV['base_url'] + '/gadgets/api/rpc?st=default%3AmiuZPNRf0H01UVrp3xgLp7dnR74rZIFqv7TPVAuG_wDECiSryEx3mUuEwTbh8hNwofQlyQ',payload,{:cookie => @authorisation,:content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
      # @path = JSON.parse(response.body)[0]['result']['http://localhost:8080/resources/grouprequestapp/app.xml']['iframeUrls']['createview']
      # puts "PATH: " + @path
    }

    # AppID likely to change per env. Can this be pulled from DOM? ~TD
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/apps/v1/instances/appinstance/484769c5-2b4b-4097-9abe-c49357eb55dd',:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when posting details to /gadget/api/rpc ' do
    path = '/social/rpc?st=default%3AIY41FVKzUvNqtaBiVV7jmsDqQm3Ye-HmSJUkoN5kHYICiTdx__WxA9XylnhIXCaSQZPGmVL_osUITW9-4od47XoWmA_bdkW8alCVHxaT-mb0xyXBQ3cnNBh4QQPCNP2P7P6LR_j6pdHlwwKkS16KZl4D_rFADRYD7Cyfec8Eswm6vaUaVxJCgQbrFgoR490XkGsaag'

    # TODO: Understand what the payload contains here. ~TD
    payload = '[{"method":"gadgets.metadata","id":"gadgets.metadata","params":{"container":"default","ids":["http://localhost:8080/resources/grouprequestapp/app.xml"],"fields":["iframeUrls","modulePrefs.*","needsTokenRefresh","userPrefs.*","views.preferredHeight","views.preferredWidth","expireTimeMs","responseTimeMs","rpcServiceIds","tokenTTL"],"language":"en","country":"US","userId":"@viewer","groupId":"@self"}}]'

    RestClient.post(ENV['base_url'] + path,payload,{:cookie => @authorisation,:content_type => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }
  end

end
