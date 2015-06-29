require 'spec_helper'

describe 'Request a group widget' do

  it 'should return a 200 when requesting the widget app' do
    payload = '[{"method":"gadgets.metadata","id":"gadgets.metadata","params":{"container":"default","ids":["http://localhost:8080/resources/grouprequestapp/app.xml"],"fields":["iframeUrls","modulePrefs.*","needsTokenRefresh","userPrefs.*","views.preferredHeight","views.preferredWidth","expireTimeMs","responseTimeMs","rpcServiceIds","tokenTTL"],"language":"en","country":"US","userId":"@viewer","groupId":"@self"}}]'

    RestClient.post(ENV['base_url'] + '/gadgets/api/rpc?st=default%3A9i0OgHD63nXlh4rEGc7NAVeOwr-gXHXIbRDB-rjS59JyIcr2iLaKuJcMF8CQEektnY2ts1aiW20TkheTyAHXsGg59Rk',payload,{:cookie => @authorisation,:content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
      @path = JSON.parse(response.body)[0]['result']['http://localhost:8080/resources/grouprequestapp/app.xml']['iframeUrls']['createview']
    }

    RestClient.get('http:' + @path,:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when posting details to /gadget/api/rpc ' do
    path = '/gadgets/api/rpc?st=default%3AgQBAlQoOc0dpiuwza9sfz-an-qTIFsZp_lD-HD-SU4lVdz-9BwrHGUwrTAPBYm5Vsvoju93oacS3pl3xLH58VAj6Dzs'

    payload = '[{"method":"gadgets.metadata","id":"gadgets.metadata","params":{"container":"default","ids":["http://localhost:8080/resources/grouprequestapp/app.xml"],"fields":["iframeUrls","modulePrefs.*","needsTokenRefresh","userPrefs.*","views.preferredHeight","views.preferredWidth","expireTimeMs","responseTimeMs","rpcServiceIds","tokenTTL"],"language":"en","country":"US","userId":"@viewer","groupId":"@self"}}]'

    RestClient.post(ENV['base_url'] + path,payload,{:cookie => @authorisation,:content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end