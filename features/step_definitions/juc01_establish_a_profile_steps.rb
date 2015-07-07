Given /^"([^"]*)" has updated their profile$/ do |user|
  @browser.cookies.delete 'jive.security.context'
  @browser.cookies.add 'jive.security.context', $browsers[user]

  user_profile = TestConfig.return_profile(user)

  RestClient.get(ENV['base_url'] + '/edit-profile!input.jspa?targetUser=' + user_profile[:user_id],:cookie => Request.create_cookie(@browser.cookies.to_a)){|response|
    fail('Failed with ' + response.code.to_s) if response.code != 200

    @token = response.body.scan(/edit.profile.[0-9]*" value=".*"/)[0].split('="')[1].gsub('"','')
  }

  payload = create_profile_payload(
              Faker::Name.prefix,
              Faker::PhoneNumber.phone_number,
              Faker::PhoneNumber.phone_number,
              Faker::Internet.email,
              Faker::Lorem.sentence,
              user_profile[:username],
              user_profile[:user_id],
              @token
            )

  RestClient.post(ENV['base_url'] + '/edit-profile.jspa',payload,:cookie => Request.create_cookie(@browser.cookies.to_a)){|response|
    fail('Failed with ' + response.code.to_s) if response.code != 302
  }
end

When(/^I navigate to the feeds page as "([^"]*)"$/) do |user|
  @browser.cookies.delete 'jive.security.context'
  @browser.cookies.add 'jive.security.context', $browsers[user]

  sleep 5 # We wait a few seconds to allow Jive to catch up and register the profile updates - MW

  RestClient.get(ENV['base_url'] + '/activity',:cookie => Request.create_cookie(@browser.cookies.to_a)){|response|
    fail('Failed with ' + response.code.to_s) if response.code != 200
    @response = response
  }
end

Then /^I am informed that "([^"]*)" has updated their profile$/ do |user|
  user_profile = TestConfig.return_profile(user)

  html_doc = Nokogiri::HTML(@response)
  fail('User updated feed item missing') unless html_doc.css('.j-last-updated').text.strip.include?(user_profile[:username])
end

Given /^I have navigated to the edit profile privacy page as "([^"]*)"$/ do |user|
  @browser.cookies.delete 'jive.security.context'
  @browser.cookies.add 'jive.security.context', $browsers[user]

  @user_profile = TestConfig.return_profile(user)

  RestClient.get(ENV['base_url'] + '/edit-profile-security!input.jspa?targetUser=' + @user_profile[:user_id],:cookie => Request.create_cookie(@browser.cookies.to_a)){|response|
    fail('Failed with ' + response.code.to_s) if response.code != 200

    html_doc = Nokogiri::HTML(response)
    @token = html_doc.css('input[name*="edit.profile.security"]')[0]['value']
  }
end

When /^I make changes to my privacy details and save them$/ do
  @name_level = '100' + (2 * rand(3) + 1).to_s

  payload = create_privacy_payload(@name_level, @user_profile[:username], @user_profile[:user_id], @token)

  RestClient.post(ENV['base_url'] + '/edit-profile-security.jspa',payload,:cookie => Request.create_cookie(@browser.cookies.to_a)){|response|
    fail('Failed with ' + response.code.to_s) if response.code != 302
  }
end

Then /^my privacy profile details are updated$/ do
  RestClient.get(ENV['base_url'] + '/edit-profile-security!input.jspa?targetUser=' + @user_profile[:user_id],:cookie => Request.create_cookie(@browser.cookies.to_a)){|response|
    fail('Failed with ' + response.code.to_s) if response.code != 200

    html_doc = Nokogiri::HTML(response)
    id = html_doc.css('select[id="nameSecurityLevelID"] > option[selected="selected"]')[0]['value']

    fail('Security level for name didn\'t update') unless id.include? @name_level
  }
end

Given /^I have navigated to the edit profile page as "([^"]*)"$/ do |user|
  @browser.cookies.delete 'jive.security.context'
  @browser.cookies.add 'jive.security.context', $browsers[user]

  @user_profile = TestConfig.return_profile(user)

  RestClient.get(ENV['base_url'] + '/edit-profile!input.jspa?targetUser=' + @user_profile[:user_id],:cookie => Request.create_cookie(@browser.cookies.to_a)){|response|
    fail('Failed with ' + response.code.to_s) if response.code != 200

    @token = response.body.scan(/edit.profile.[0-9]*" value=".*"/)[0].split('="')[1].gsub('"','')
  }
end

When /^I make changes to my profiles details and save them$/ do
  @prefix   = Faker::Name.prefix
  @phone_1  = Faker::PhoneNumber.phone_number
  @phone_2  = Faker::PhoneNumber.phone_number
  @email    = Faker::Internet.email
  @sentence = Faker::Lorem.sentence

  payload = create_profile_payload(
              @prefix,
              @phone_1,
              @phone_2,
              @email,
              @sentence,
              @user_profile[:username],
              @user_profile[:user_id],
              @token
            )

  RestClient.post(ENV['base_url'] + '/edit-profile.jspa',payload,:cookie => Request.create_cookie(@browser.cookies.to_a)){|response|
    fail('Failed with ' + response.code.to_s) if response.code != 302
  }
end

Then /^my profile details are updated$/ do
  RestClient.get(ENV['base_url'] + '/edit-profile!input.jspa?targetUser=' + @user_profile[:user_id],:cookie => Request.create_cookie(@browser.cookies.to_a)){|response|
    fail('Failed with ' + response.code.to_s) if response.code != 200

    html_doc = Nokogiri::HTML(response)
    fail('Prefix not updated') unless html_doc.css('input[name="profile[5006].value"]').to_s.include?(@prefix)
    fail('Phone 1 not updated') unless html_doc.css('input[name="profile[5009].phoneNumbers[0].phoneNumber"]').to_s.include?(@phone_1)
    fail('Phone 2 not updated') unless html_doc.css('input[name="profile[5008].phoneNumbers[0].phoneNumber"]').to_s.include?(@phone_2)
    fail('Email not updated') unless html_doc.css('input[name="profile[5007].emails[0].email"]').to_s.include?(@email)
    fail('Sentence not updated') unless html_doc.css('textarea[name="profile[5002].value"]').to_s.include?(@sentence)
  }
end


def create_privacy_payload(name_level, username, user_id, token)
  {
      'nameSecurityLevelID' => name_level,
      'emailSecurityLevelID' => '1005',
      'profile[5004].effectiveSecurityLevelID' => '1001',
      'profile[5005].effectiveSecurityLevelID' => '1001',
      'profile[5006].effectiveSecurityLevelID' => '1005',
      'profile[5009].effectiveSecurityLevelID' => '1005',
      'profile[5008].effectiveSecurityLevelID' => '1005',
      'profile[5007].effectiveSecurityLevelID' => '1005',
      'profile[5002].effectiveSecurityLevelID' => '1001',
      'imageSecurityLevelID' => '1005',
      'creationDateSecurityLevelID' => '1005',
      'lastLoginSecurityLevelID' => '1001',
      'save' => 'Save',
      'username' => username,
      'targetUser' => user_id,
      'jive.token.name' => 'edit.profile.security.' + user_id,
      'edit.profile.security.' + user_id => token,
      :multipart => true
  }
end

def create_profile_payload(prefix, phone_1, phone_2, email, sentence, username, user_id, token)
  {
      'profile[5005].typeID'  => '8',
      'profile[5005].fieldID'  => '5005',
      'profile[5005].value'  => 'Analyst',
      'profile[5006].typeID'  => '9',
      'profile[5006].fieldID'  => '5006',
      'profile[5006].value'  => prefix,
      'profile[5009].typeID'  => '11',
      'profile[5009].fieldID'  => '5009',
      'profile[5009].phoneNumbers[0].phoneNumber'  => phone_1,
      'profile[5009].phoneNumbers[0].typeString'  => 'other',
      'profile[5008].typeID'  => '11',
      'profile[5008].fieldID'  => '5008',
      'profile[5008].phoneNumbers[0].phoneNumber'  => phone_2,
      'profile[5008].phoneNumbers[0].typeString'  => 'other',
      'profile[5007].typeID'  => '4',
      'profile[5007].fieldID'  => '5007',
      'profile[5007].emails[0].email'  => email,
      'profile[5007].emails[0].typeString'  => 'other',
      'profile[5002].typeID'  => '6',
      'profile[5002].fieldID'  => '5002',
      'profile[5002].value'  => sentence,
      'save'  => 'Save',
      'username'  => username,
      'targetUser'  => '2012',
      'jive.token.name'  => 'edit.profile.' + user_id,
      'edit.profile.' + user_id  => token,
      :multipart => true
  }
end
