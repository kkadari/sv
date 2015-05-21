class GlobalNav
  include PageObject

  link(:people, :text => 'people')
  link(:home, :text => 'Home')
  link(:content, :text => 'Content')
  link(:open_create, :id => 'navCreate')
  div(:create_menu, :id => 'menuCreate')
  link(:create_discussion, :css => '#create-list-0 li:nth-child(1) a')
  link(:create_blog, :css => '#create-list-0 li:nth-child(2) a')
  link(:create_poll, :css => '#create-list-0 li:nth-child(3) a')
  link(:create_incident_report, :css => '#create-list-0 li:nth-child(5) a')
  link(:create_space, :class => 'js-createmenu-containerchooser')
  link(:create_group, :css => 'a[href*="edit-place"]')

  # To be reviewed once spotlight search has been restored - MW

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

end