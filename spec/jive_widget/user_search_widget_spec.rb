require 'spec_helper'

describe 'User search widget' do

  it 'should return a 200 when searching for users' do
    path = '/__services/v2/rest/users/search/Test?numResults=100' +
           '&emailAllowed=false' +
           '&userAllowed=true' +
           '&listAllowed=true' +
           '&canInvitePartners=true' +
           '&canInviteJustPartners=false' +
           '&canInvitePreprovisioned=false' +
           '&invitePreprovisionedDomainRestricted=false' +
           '&propNames=avatarID' +
           '&propNames=hasConnection' +
           '&propNames=title' +
           '&propNames=department' +
           '&objectID=3611' +
           '&objectType=2' +
           '&entitlement=VIEW'

    RestClient.get(ENV['base_url'] + path,:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when requesting the user search widget' do
    RestClient.get(ENV['base_url'] + '/user-autocomplete-modal.jspa?multiple=true&canInvitePartners=true',:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when retrieving details about a specific user' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/users/' + @id + '?objectID=3611&objectType=2&entitlement=VIEW',:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when searching for specific users for person' do
    path = '?filterGroupID=placePeople' +
           '&token=MTQzNTIyMjU0MDIzMHwyMHxbQkA3ZjgyNGIwNg%3D%3D' +
           '&itemViewID=detail' +
           '&start=0' +
           '&numResults=20' +
           '&containerType=14' +
           '&containerID=' + @space_id +
           '&filterID=place_follower' +
           '&itemView=detail' +
           '&userID=' + @id
           '&sortKey=place_follower~lastNameAsc' +
           '&sortOrder=1'

    RestClient.get(ENV['base_url'] + '/__services/v2/rest/users/' + @id + '/browse' + path,:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end