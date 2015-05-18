module SearchBox
  include PageObject

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