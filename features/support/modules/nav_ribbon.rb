module NavRibbon
  include PageObject

  def click_home
    @browser.link(:text => /Home/).when_present.click
  end

  def click_content
    @browser.link(:text => /Content/).when_present.click
  end

  def click_people
    @browser.link(:text => /People/).when_present.click
  end

  def click_places
    @browser.link(:text => /Places/).when_present.click
  end

  def click_create
    @browser.link(:id => 'navCreate').when_present.click
    @browser.div(:id => 'menuCreate').wait_until_present
  end
  
  def click_create_group
    @browser.link(:text => 'Group').when_present.click
  end
  
  def click_create_space
    @browser.link(:text => 'Space').when_present.click
  end
  
  def click_request_group
    @browser.link(:text => 'Apply for a new Group').when_present.click
  end
  
  def verify_cannot_create(type)
    click_create
    case type
      when 'group'
        fail 'User should not have option to create group.' if @browser.link(:text => 'Group').present?
      when 'space'
        fail 'User should not have option to create space.' if @browser.link(:text => 'Space').present?
      else
        fail 'Supplied link type not defined.'
    end
  end
end