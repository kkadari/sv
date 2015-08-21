Given /^I am on the People page$/ do
  switch_user('participant A')
  @user_profile = TestConfig.return_profile('participant A')

  People.get_browse_people($authorisation)
end

When /^I opt to add a filter$/ do
  People.get_browse_people_by_skill_all(@user_profile[:user_id], $authorisation)
end

Then /^I can choose to filter by organisation$/ do
  People.order_by_organisation_all(@user_profile[:user_id], $authorisation)
end

Then /^opting to filter by organisation will return people within a specific organisation$/ do
  response = People.order_by_specific_organisation(@user_profile[:user_id], 'Cert', $authorisation)

  fail('Search people by organisation failed') unless JSON.parse(response.split(';',0)[1])['items'][0]['subject'] == 'certtestuser@cert'
end