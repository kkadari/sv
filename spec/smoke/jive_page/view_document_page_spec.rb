require 'spec_helper'

describe 'Document page' do

  before(:all) do
    payload = DocumentPayload
                  .new(Faker::Lorem.words(10).join(','),
                       'body content here',
                       'red',
                       'test.jpg').payload

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/document/upload',payload,{:cookie => @authorisation,:content_type => 'application/json'}){|response|
      @document_id = response.body.scan(/docs\/DOC-[0-9]*/)[0].split('/')[1]
    }
  end

  it 'should return a 200 when requesting the page' do
    RestClient.get(ENV['base_url'] + '/docs/' + @document_id,{:cookie => @authorisation, :content_type => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when requesting the version page' do
    RestClient.get(ENV['base_url'] + '/docs/' + @document_id + '/version',{:cookie => @authorisation, :content_type => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when requesting a specific version of the document' do
    RestClient.get(ENV['base_url'] + '/docs/' + @document_id + '/version/1',{:cookie => @authorisation, :content_type => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }
  end

end