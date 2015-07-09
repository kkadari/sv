Given /^a participant has raised an anonymous incident report in a group I follow in my connections stream$/ do
  @browser.cookies.delete 'jive.security.context'
  @browser.cookies.add 'jive.security.context', $browsers['participant A']

  visit_and_benchmark CustomGroupPage, :using_params => {:id => @test_config_set[:private_group]} do | customgroup |
    customgroup.follow unless customgroup.following_element.exists?
  end

  @browser.cookies.delete 'jive.security.context'
  @browser.cookies.add 'jive.security.context', $browsers['participant B']

  @subject = TitleCreator.create_title_for('incident')

  response = CreateContent.create_incident_report @browser.cookies.to_a, @subject, 'Lorem ipsumy goodness', 'random', Hash[:type => 'private group'], '', true
  @incident_id = response['redirect'][/[0-9]+/,0]
  @incident_url = UrlFactory.incidentreportsummaryparampage + response['redirect']
end

Then /^I can verify the incident report is marked anonymous in my connection stream$/ do
  @browser.cookies.delete 'jive.security.context'
  @browser.cookies.add 'jive.security.context', $browsers['participant A']

  visit_and_benchmark ActivityPage do |act|
    act.connections_stream
    @incident_report = act.incident_report_element
    act.wait_until do
      act.header.include? 'Connections Stream'
    end
  end

  !fail 'Not marked with anonymous avatar' unless @incident_report.html.to_s.include? 'anonymous-avatar'
  !fail 'Not marked as anonymous' unless @incident_report.text.include? 'Anonymous'
  !fail 'Username visible' if @incident_report.text.include? @test_config_set[:user_2_name]
end

Then /^I am not able to view their identity on the comment in their activity stream$/ do
  visit_and_benchmark PeoplePage, :using_params => {:id => @test_config_set[:user_2_name]}
  on(UserOneProfilePage).activity
  on(UserOneActivityStreamPage).show_all
  on(UserOneActivityStreamPage).wait_until do
    on(UserOneActivityStreamPage).comment?
  end

  !fail 'Not marked as anonymous' unless on(UserOneActivityStreamPage).comment.include? 'Anonymous'
  !fail 'Username visible' if on(UserOneActivityStreamPage).comment.include? @test_config_set[:user_1_name]
end

Then /^another user is not able to view it in my activity stream$/ do
  @browser.cookies.delete 'jive.security.context'
  @browser.cookies.add 'jive.security.context', $browsers['participant B']

  visit_and_benchmark PeoplePage, :using_params => {:id => @test_config_set[:user_1_name]}

  !fail 'Anonymous content visible' unless @browser.html.to_s.include? 'Anonymous'
end

Then /^I can see the incident in my activity stream$/ do
  navigate_to(HomePage)
  fail 'Incident not visible or created' unless @browser.html.to_s.include? subject
end