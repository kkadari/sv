require 'spec_helper'

describe 'Preferences page' do

  it 'should return a 200 when requested' do
    RestClient.get(ENV['base_url'] + '/user-preferences!input.jspa',:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when requesting the hidden activity rules' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/exclusion/list',:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 304 when posting changes to your preferences' do
    payload = 'jive.token.name=user.preferences&user.preferences=1434451670855-EK30VM0PSL4A75NEBITGC5BPI77IBE0V' +
              '&notifyPreferences%5B%2736%27%5D=true' +
              '&notifyPreferences%5B%27directActions%27%5D=true' +
              '&notifyPreferences%5B%27inboxNotifications%27%5D=true' +
              '&notifyPreferences%5B%27notifyModerationQueue%27%5D=false' +
              '&notifyPreferences%5B%2737%27%5D=false' +
              '&emailFrequencyOption=never' +
              '&userOnboardingEnabled=true' +
              '&threadMode=threaded' +
              '&commentThreadMode=threaded' +
              '&userLocale=NO_LOCALE' +
              '&timezone=Etc%2FGMT&wcagStyles=false' +
              '&contentTagEditMode=false' +
              '&save=Save'

    RestClient.post(ENV['base_url'] + '/user-preferences.jspa',payload,:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

end