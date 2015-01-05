module GroupRequest
  include PageObject
  include DataMagic
  
  text_field(:name){ @browser.iframe(:id => '__gadget_j-app-modal-parent').text_field(:id, 'group-name-input') }
  text_field(:description){ @browser.iframe(:id => '__gadget_j-app-modal-parent').text_field(:id => 'jive-socialgroup-desc') }
  
  def request_group_created(data = {})
    # Wait for iframe to load 
    @browser.iframe(:id => '__gadget_j-app-modal-parent').when_present do
      @ifr = @browser.iframe(:id => '__gadget_j-app-modal-parent')
      @ifr.text_field(:id => 'jive-socialgroup-desc').wait_until_present
      populate_page_with data_for(:GroupRequest, data)
      set_group_owner(FigNewton.user1_uname)
      set_additional_owner(FigNewton.user2_uname)
      set_group_supporters([FigNewton.adminuser_uname, FigNewton.user2_uname])
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
    sleep 3
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
      sleep 3
      # Jump inside table, grab the label of first term, then set (click) the associated input (checkbox)
      label = @browser.label(:xpath => '//*[@id="jive-table-userpicker-body"]/table/tbody/tr[1]/td[1]/label')
      @browser.checkbox(:id => label.for).when_present.set
      @browser.div(:id => 'jive-people-search').text_field(:id => 'query').clear
    end
  end
end