module CreateModal
  include PageObject

  #TODO: Regex all the links. ~MW

  def click_to_create_type(type)
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
end