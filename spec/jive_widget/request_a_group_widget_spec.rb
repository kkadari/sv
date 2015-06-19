require 'spec_helper'

describe 'Request a group widget' do

  it 'should return a 200 when requesting the widget app' do
    path =  '/gadgets/ifr?url=http%3A%2F%2Flocalhost%3A8080%2Fresources%2Fgrouprequestapp%2Fapp.xml' +
            '&container=default' +
            '&view=createview' +
            '&lang=en' +
            '&country=US' +
            '&debug=0' +
            '&nocache=0' +
            '&sanitize=0' +
            '&v=db1de2a024a270a1a00ea5a64aac86a0&st=default%3AEjy691m2drCbAtbOkOWMI6-u5GtJMZokzCFab9WOaHL86aVs8feSWVvopJZae5f9NM2LE6b6JQmO7XEW_DfdFBLImxyhqoajnkz8ppgm-Ww7xpbDHu7I0B7H5BjvCCg8m2hte3uxcrW5VJUSOoCFdRUkufq3d_MCJArbDvrKGOXmOjt01Kyp5P-CvEV5QKwIj_iecg' +
            '&testmode=0' +
            '&parent=http%3A%2F%2Fdev188.sure.vine' +
            '&mid=0'

    RestClient.get(ENV['base_url'] + path,:cookie => @authorisation){|response|
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

  it 'should return a 200 when posting details of a group creation request' do
    path = '/social/rpc?st=default%3Ayt5azPhS7DVO2LUdOxamACoh0rQkBJClXYT8vg_FleKjlPmxmrYdHBs2UnO_JXEpdptfVnP8XXeXEtOvgV9Eq4qcSu8JWrzarkdnt742Umv89ugzW0smbM_rkHK5A0_flzmMs4jISjY_53ctbsvAF8feM3KHLUqFEr-fpwWNmGevhdq2FIBlKZ4umUQlOh3naaGWbQ'

    payload = '[{"method":"jive.core.post","id":"jive.core.post","params":{"v":"v3","href":"/activities","body":{"title":"Group Owner Name: markw@surevine.  Description/Business Case: Ignore this.  It\'s part of an auto test suite run.  Second Owner Name: admin . With supporters: admin. The following features were requested: blog, documents, discussions, polls, incidentReports. ","content":"Request group creation with name Test group, from markw@surevine","openSocial":{"deliverTo":["//dev188.sure.vine/api/core/v3/people/1"]}},"userId":"@viewer","groupId":"@self"}}]'

    RestClient.post(ENV['base_url'] + path,payload,{:cookie => @authorisation,:content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end