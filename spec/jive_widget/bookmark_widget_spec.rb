require 'spec_helper'

describe 'Bookmark widget' do

  it 'should return a 200 when bookmarking a piece of content' do
    RestClient.post(ENV['base_url'] + '/__services/v2/rest/bookmarks','{"bookmarkCount":1,"markedObjectType":"18","markedObjectId":"1821"}',{:cookie => @authorisation, :content_type => 'application/json', :accept => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when requesting the edit bookmark popup' do
    RestClient.get(ENV['base_url'] + '/polls/create-favorite-popup!input.jspa?contentObjectType=18&object=1821',:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when posting an edit to a bookmark' do
    payload = 'url=&object=1821&contentObjectType=18&__checkbox_visibility=all&jive.token.name=create.bookmark.1821&create.bookmark.1821=1434717607373-98EDDH7F1P9U0QHM91LC4GFCAS353DDD&notes=Some+notes+in+here&tags=&bookmark-submit=Save'

    RestClient.post(ENV['base_url'] + '/create-favorite-popup.jspa',payload,{:cookie => @authorisation, :content_type => 'application/json', :accept => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when requesting all bookmarks' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/bookmarks',:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when requesting a specific bookmark' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/activity/users/bookmark/18/1821',:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when deleting a specific bookmark' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/bookmarks',:cookie => @authorisation){|response|
      @id = JSON.parse(response.body.split(';',0)[1])['items'][0]['prop']['bookmarkInfo']['bookmarkID'].to_s
    }

    RestClient.delete(ENV['base_url'] + '/__services/v2/rest/bookmarks/' + @id,{:cookie => @authorisation, :accept => '*/*'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 204
    }
  end

end