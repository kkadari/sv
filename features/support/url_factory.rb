module UrlFactory
  
  def loginpage
    return ENV['base_url'] + "login.jspa"
  end
  
  def activitypage
    return ENV['base_url'] + "activity"
  end
  
  def contentpage
    return ENV['base_url'] + "content"
  end
  
end
