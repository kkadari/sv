Given /^I have requested a new group is created with participant B as an additional owner and a supporter$/ do
  visit_and_benchmark HomePage

  on(GlobalNav) do |menu|
    menu.wait_until do
      menu.open_create?
    end

    menu.open_create

    menu.wait_until do
      menu.request_group?
    end

    menu.request_group
  end

  on(RequestANewGroup) do |group|
    group.wait_until do
      group.group_name?
    end

    group.group_name = 'Auto request for group'
    group.group_desc = 'Description for the group'
    group.additional_owner
  end

  on(SearchPersonPicker) do |search_picker|
    search_picker.wait_until do
      search_picker.alpha_link?
    end

    search_picker.alpha_link

    search_picker.wait_until do
      search_picker.simon_user?
    end

    search_picker.check_simon_user
  end

  on(RequestANewGroup) do |group|
    group.wait_until do
      group.additional_owner?
    end

    group.additional_owner
  end

  on(SearchPersonPicker) do |search_picker|
    search_picker.wait_until do
      search_picker.alpha_link?
      sleep(1)
    end

    search_picker.alpha_link

    search_picker.wait_until do
      search_picker.simon_user?
    end

    search_picker.check_simon_user
  end

  on(RequestANewGroup) do |group|
    group.wait_until do
      group.request?
    end

    group.request
  end
end

Then /^I have received the group creation request in my inbox$/ do
  5.times do |i|
    begin
      visit_and_benchmark InboxPage, :using_params => {:query => '?filter=notifications&et=extendedcontent.expertise.moderation&%3FobjectType=-1805099612'} do |inbox|
        inbox.notifications

        inbox.wait_until do
          inbox.inbox_message?
        end

        fail('Notification not received') unless inbox.inbox_message_element.text.include? 'stephaniek@surevine added you as a potential second owner for a group named \'Auto request for group\'.'
        fail('Notification description not correct') unless inbox.inbox_message_element.text.downcase.include? 'the group has the following description: description for the group'

        inbox.confirm_notification
      end
      break
    rescue => e
      if i < 5
        sleep(1)
      else
        fail(e)
      end
    end
  end
end

Given /^I have opted to request a new group$/ do
  switch_user('participant A')
  visit_and_benchmark HomePage

  on(GlobalNav) do |menu|
    menu.wait_until do
      menu.open_create?
    end

    menu.open_create

    menu.wait_until do
      menu.request_group?
    end

    menu.request_group
  end
end

When /^I leave the mandatory fields blank$/ do
  on(RequestANewGroup) do |group|
    group.wait_until do
      group.group_name?
    end

    group.group_name_element.clear
    group.group_desc_element.clear
  end
end

When /^I attempt to submit the request$/ do
  on(RequestANewGroup) do |group|
    group.wait_until do
      group.request?
    end

    group.request
  end
end

Then /^I will receive validation errors for the missing content$/ do
  on(RequestANewGroup) do |group|
    group.wait_until do
      group.alert?
    end

    fail('Error message not shown') unless group.alert?
  end
end