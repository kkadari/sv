require 'spec_helper'

describe 'People search widget' do

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
           '&objectID=1781' +
           '&objectType=1' +
           '&entitlement=VIEW'

    RestClient.get(ENV['base_url'] + path,:cookie => @authorisation){|response|
      @location = response.headers[:location]
    }
  end

  it 'should return a 200 when requesting the user search widget' do
    RestClient.get(ENV['base_url'] + '/user-autocomplete-modal.jspa?multiple=true&canInvitePartners=true',:cookie => @authorisation){|response|
      @location = response.headers[:location]
    }
  end

  it 'should return a 200 when retrieving details about a specific user' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/users/2012?objectID=1781&objectType=1&entitlement=VIEW',:cookie => @authorisation){|response|
      @location = response.headers[:location]
    }
  end

end