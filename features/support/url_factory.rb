module UrlFactory

  def homepage
    ENV['base_url'] + '/'
  end

  def spacepage
    ENV['base_url'] + '/community/getting-started'
  end

  def inboxpage
    ENV['base_url'] + '/inbox<%=params[:query]%>'
  end

  def activitypage
    ENV['base_url'] + '/activity'
  end

  def contentpage
    ENV['base_url'] + '/content'
  end

  def blogpostsummarypage
    ENV['base_url'] + "/people/#{/.*/}"
  end

  def viewuploadeddocumentpage
    ENV['base_url'] + "/docs/#{/.*/}"
  end

  def discussionsummarypage
    ENV['base_url'] + '/message/<%=params[:id]%>'
  end

  def creategrouppage
    ENV['base_url'] + '/create-group!input.jspa?sr=cmenu'
  end

  def grouppage
    ENV['base_url'] + '/groups/<%=params[:id]%>'
  end

  def incidentreportsummarypage
    /#{ENV['base_url']}\/view\-incidentreport\.jspa\?incidentReportID\=\d+/
  end

  def advsearchpage
    ENV['base_url'] + '/search'
  end

  def viewdiscussionpage
    /#{ENV['base_url']}thread\/\d+/
  end

  def placespage
    ENV['base_url'] + '/places'
  end

  def pollsummarypage
    ENV['base_url'] + '/polls/<%=params[:id]%>'
  end

  def useroneprofilepage
    ENV['base_url'] + '/people/<%=params[:id]%>'
  end

  def self.cannotcreategrouppage
    ENV['base_url'] + '/edit-place.jspa?sr=cmenu&containerType=700'
  end

  def self.incidentreportsummaryparampage
    ENV['base_url'] + '/view-incidentreport.jspa?incidentReportID='
  end

  def self.cannotcreateplacepage
    ENV['base_url'] + '/edit-place.jspa?parentObjectID=1&parentObjectType=14&containerType=14'
  end

  def peoplepage
    ENV['base_url'] + '/people/<%=params[:id]%>'
  end

end
