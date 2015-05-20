class GlobalNav
  include PageObject
  include DataMagic

  link(:people, :text => 'people')
  link(:home, :text => 'Home')
  link(:content, :text => 'Content')

  def verify_cannot_create(type)
    @browser.link(:id => 'navCreate').when_present.click
    @browser.div(:id => 'menuCreate').wait_until_present
    case type
      when 'group'
        fail 'User should not have option to create group.' if @browser.link(:text => 'Group').present?
      when 'space'
        fail 'User should not have option to create space.' if @browser.link(:text => 'Space').present?
      else
        fail 'Supplied link type not defined.'
    end
  end

  #TODO: Regex all the links. ~MW
  def click_to_create_type(type)
    @browser.link(:id => 'navCreate').when_present.click
    @browser.div(:id => 'menuCreate').wait_until_present

    case type
      when 'discussion'
        @browser.link(:href => '/discussion/create.jspa?sr=cmenu&containerType=14&containerID=1').when_present.click
      when 'blog'
        @browser.link(:href => '/blog/create-post.jspa?sr=cmenu&containerType=14&containerID=1').when_present.click
      when 'poll'
        @browser.link(:href => '/poll/create.jspa?sr=cmenu&containerType=14&containerID=1').when_present.click
      when 'message'
        @browser.link(:class => 'quick j-selected', :data_content_type => '109016030').when_present.click
      when 'incident_report'
        @browser.link(:href => '/incidentreports/create-incidentreport.jspa!input?sr=cmenu&containerType=14&containerID=1').when_present.click
      when 'uploaded_file'
        @browser.link(:href => '/document/upload.jspa?sr=cmenu&containerType=-1&containerID=-1').when_present.click
      when 'space'
        @browser.link(:text => /Space/).when_present.click
      when 'group'
        @browser.link(:href => '/create-group!input.jspa?sr=cmenu').when_present.click
      when 'request_group'
        @browser.link(:text => 'Apply for a new Group').when_present.click
      else
        raise "Cannot create a content or place type of #{content_type}."
    end
  end

  def search_for(term)
    @browser.text_field(:id, 'autosearch').when_present.set(term)
    @browser.send_keys :return
  end

  def click_search_result(term)
    @browser.link(:text, /#{term}/).when_present.click
  end

  def verify_spotlight_search_result_exists(term)
    attempt = 0
    begin
      @browser.text_field(:id, 'autosearch').when_present.set(term)
      @browser.div(:class => "j-results", :data_type => "people").wait_until_present
      @browser.span(:class => "result-title").when_present.text.include?(term)
    rescue
      attempt += 1
      if attempt <= 3 # Retry up to 3 times.
        @browser.text_field(:id, 'autosearch').when_present.set('')
        retry
      end
      raise 'Search term not found'
    end
  end

  def verify_spotlight_search_result_exists_for_incident_id(search_id, expected_result)
    attempt = 0
    begin
      @browser.text_field(:id, 'autosearch').when_present.set(search_id)
      @browser.div(:class => "j-results", :data_type => "contents").wait_until_present
      @browser.span(:class => "result-title").when_present.text.include?(expected_result)
    rescue
      attempt += 1
      if attempt <= 3 # Retry up to 3 times.
        @browser.text_field(:id, 'autosearch').when_present.set('')
        retry
      end
      raise 'Incident not found'
    end
  end

  text_field(:name){ @browser.iframe(:id => '__gadget_j-app-modal-parent').text_field(:id, 'group-name-input') }
  text_field(:description){ @browser.iframe(:id => '__gadget_j-app-modal-parent').text_field(:id => 'jive-socialgroup-desc') }

  def request_group_created(data = {})
    # Wait for iframe to load
    @browser.iframe(:id => '__gadget_j-app-modal-parent').when_present do
      @ifr = @browser.iframe(:id => '__gadget_j-app-modal-parent')
      @ifr.text_field(:id => 'jive-socialgroup-desc').wait_until_present
      populate_page_with data_for(:GroupRequest, data)
      set_group_owner(TestConfig.user1_uname)
      set_additional_owner(TestConfig.user2_uname)
      set_group_supporters([TestConfig.adminuser_uname, TestConfig.user2_uname])
      @ifr.button(:id => 'requestNewGroup').when_present.click
    end
  end

  def set_group_owner(user)
    @ifr.button(:id => 'btn_owner_picker').when_present.click
    select_people_single(user)
  end

  def set_additional_owner(user)
    @ifr.button(:id => 'second_btn_owner_picker').when_present.click
    select_people_single(user)
  end

  def set_group_supporters(users = {})
    @ifr.button(:id => 'second_btn_owner_picker').when_present.click
    select_people_multiple(users)
  end

  def select_people_single(user)
    @browser.div(:id => 'user-autocomplete-modal-container').wait_until_present
    @browser.li(:id => 'jive-search-tab').link(:title => 'Search for people').when_present.click
    # Narrow search results to username only (set by default)
    @browser.link(:id => 'userpicker-options-link', :text => "More options").when_present.click
    @browser.checkbox(:id => 'profileEnabled').when_present.clear # uncheck
    @browser.checkbox(:id => 'emailEnabled').when_present.clear # uncheck
    @browser.checkbox(:id => 'nameEnabled').when_present.clear # uncheck
    # Enter search term and wait for results
    @browser.div(:id => 'jive-people-search').text_field(:id => 'query').when_present.set(user)
    @browser.button(:id => 'people-search-submit').when_present.click
    @browser.div(:id => 'jive-table-userpicker-body').wait_until_present

    # Jump inside table, grab the label of first term, then set (click) the associated input (checkbox)
    label = @browser.label(:xpath => '//*[@id="jive-table-userpicker-body"]/table/tbody/tr[1]/td[1]/label')
    @browser.checkbox(:id => label.for).when_present.set
  end

  def select_people_multiple(users = {})
    @browser.div(:id => 'user-autocomplete-modal-container').wait_until_present
    @browser.li(:id => 'jive-search-tab').link(:title => 'Search for people').when_present.click
    # Narrow search results to username only (set by default)
    @browser.link(:id => 'userpicker-options-link', :text => "More options").when_present.click
    @browser.checkbox(:id => 'profileEnabled').when_present.clear # uncheck
    @browser.checkbox(:id => 'emailEnabled').when_present.clear # uncheck
    @browser.checkbox(:id => 'nameEnabled').when_present.clear # uncheck
    @browser.div(:id => 'jive-people-search').text_field(:id => 'query').wait_until_present
    # Iterate through users array, clicking the result each time (adds it to selected people)
    users.each do |user|
      # Enter search term and wait for results
      @browser.div(:id => 'jive-people-search').text_field(:id => 'query').set(user)
      @browser.button(:id => 'people-search-submit').when_present.click
      @browser.div(:id => 'jive-table-userpicker-body').wait_until_present

      # Jump inside table, grab the label of first term, then set (click) the associated input (checkbox)
      label = @browser.label(:xpath => '//*[@id="jive-table-userpicker-body"]/table/tbody/tr[1]/td[1]/label')
      @browser.checkbox(:id => label.for).when_present.set
      @browser.div(:id => 'jive-people-search').text_field(:id => 'query').clear
    end
  end

end