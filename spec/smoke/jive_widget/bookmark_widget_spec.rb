require 'spec_helper'

describe 'Bookmark widget' do

  before(:all) do
    payload = IncidentReportPayload
                  .new('Bookmark test',
                       false,
                       'body content goes here',
                       'red',
                       Hash[:type => 'community'],
                       'test, test2',
                       false).payload

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/incidentReports/',payload,{:cookie => @authorisation,:content_type => 'application/json'}){|response|
      @document_id = response.body.scan(/reports\/[0-9]*/)[0].split('/')[1]
    }
  end

  it 'should return a 200 when bookmarking a piece of content' do
    RestClient.post(ENV['base_url'] + '/__services/v2/rest/bookmarks','{"bookmarkCount":1,"markedObjectType":"11111","markedObjectId":"' + @document_id + '"}',{:cookie => @authorisation, :content_type => 'application/json', :accept => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when requesting the edit bookmark popup' do
    RestClient.get(ENV['base_url'] + '/polls/create-favorite-popup!input.jspa?contentObjectType=11111&object=' + @document_id,:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when posting an edit to a bookmark' do
    payload = 'url=&object=' + @document_id + '&contentObjectType=11111&__checkbox_visibility=all&jive.token.name=create.bookmark.' + @document_id + '&create.bookmark.' + @document_id + '=1434717607373-98EDDH7F1P9U0QHM91LC4GFCAS353DDD&notes=Some+notes+in+here&tags=&bookmark-submit=Save'

    RestClient.post(ENV['base_url'] + '/create-favorite-popup.jspa',payload,{:cookie => @authorisation, :content_type => 'application/json', :accept => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when requesting all bookmarks' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/bookmarks',:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when requesting a specific bookmark' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/activity/users/bookmark/11111/' + @document_id,:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when deleting a specific bookmark' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/bookmarks',:cookie => @authorisation){|response|
      puts response
      @id = JSON.parse(response.body.split(';',0)[1])['items'][0]['prop']['bookmarkInfo']['bookmarkID'].to_s
      puts "Bookmark ID:" + @id
    }

    #RestClient.delete(ENV['base_url'] + '/__services/v2/rest/bookmarks/' + @id,{:cookie => @authorisation, :accept => '*/*'}){|response|
    #  assert_code_and_body(response, 204)
    #}
  end

end
