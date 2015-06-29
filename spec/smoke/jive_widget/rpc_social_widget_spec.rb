require 'spec_helper'

describe 'RPC Social widget' do

  it 'should return a 200 when new social data is posted' do
    path = '/social/rpc?st=default%3AETj5uDftAC_ADHRextk0vJuW_ky3-j940YFHSKRLmPErsgYbki2febICWxT_g3q9KK82Zw'
    payload = '[{"method":"jive.core.get","id":"jive.core.get","params":{"v":"v3","href":"/places/1000/announcements?count=100&activeOnly=true","params":{},"userId":"@viewer","groupId":"@self"}}]'

    RestClient.post(ENV['base_url'] + path,payload,{:cookie => @authorisation,:content_type => 'application/json'}){|response|
      @payload = JSON.parse(response.body)
    }
  end

end