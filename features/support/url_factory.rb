module UrlFactory
  
  def loginpage
    ENV['base_url'] + '/login.jspa'
  end

  def logoutpage
    ENV['base_url'] + '/logout.jspa'
  end

  def homepage
    ENV['base_url'] + '/activity'
  end

  def welcomepage
    ENV['base_url'] + '/welcome'
  end

  def spacepage
    ENV['base_url'] + "/community/#{/.*/}"
  end

  def activitypage
    ENV['base_url'] + '/activity'
  end
  
  def contentpage
    ENV['base_url'] + '/content'
  end

  def blogposteditpage
    ENV['base_url'] + "/blog/update-post#{/.*/}"
  end

  def blogpostpage
    ENV['base_url'] + '/blog/create-post.jspa?sr=cmenu&containerType=14&containerID=1'
  end

  def blogpostpdfpage
    /#{ENV['base_url']}\/people\S+.pdf/
  end

  def blogpostsummarypage
    ENV['base_url'] + "/people/#{/.*/}"
  end

  def discussioneditpage
    ENV['base_url'] + "/message/#{/.*/}/edit"
  end

  def viewuploadeddocumentpage
    ENV['base_url'] + "/docs/#{/.*/}"
  end

  def discussionpage
    ENV['base_url'] + '/discussion/create.jspa?sr=cmenu&containerType=14&containerID=1'
  end

  def discussionpdfpage
    /#{ENV['base_url']}\/thread\S\d+.pdf/
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

  def incidentreporteditpage
    ENV['base_url'] + '/incidentreports/<%=params[:id]%>/edit'
  end

  def incidentreportpage
    ENV['base_url'] + '/incidentreports/create-incidentreport.jspa!input?sr=cmenu&containerType=14&containerID=1'
  end

  def incidentreportpdfpage
    /#{ENV['base_url']}\/incidentreports\S\d+.pdf/
  end

  def incidentreportsummarypage
    /#{ENV['base_url']}\/view\-incidentreport\.jspa\?incidentReportID\=\d+/
  end

  def polleditpage
    "#{ENV['base_url']}/poll/edit#{/.*/}"
  end

  def pollpage
    ENV['base_url'] + '/poll/create.jspa?sr=cmenu&containerType=14&containerID=1'
  end

  def preferencespage
    ENV['base_url'] + '/user-preferences!input.jspa'
  end

  def advsearchpage
    ENV['base_url'] + '/search'
  end

  def viewdiscussionpage
    /#{ENV['base_url']}thread\/\d+/
  end

  def viewincidentreportpage
    ENV['base_url'] + '/incidentreports/<%=params[:id]%>'
  end

  def customgrouppage
    ENV['base_url'] + '/groups/<%=params[:id]%>'
  end

  def placespage
    ENV['base_url'] + '/places'
  end

  def pollsummarypage
    ENV['base_url'] + '/polls/<%=params[:id]%>'
  end

  def useroneactivitystreampage
    ENV['base_url'] + '/people/<%=params[:id]%>/activity'
  end

  def useroneprivacyeditpage
    ENV['base_url'] + '/edit-profile-security!input.jspa'
  end

  def useroneprofileeditpage
    ENV['base_url'] + '/edit-profile!input.jspa'
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
    ENV['base_url'] = '/edit-place.jspa?parentObjectID=1&parentObjectType=14&containerType=14'
  end

  def peoplepage
    ENV['base_url'] + '/people/<%=params[:id]%>'
  end

end
