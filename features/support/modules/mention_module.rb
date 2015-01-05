module MentionModule
  include PageObject
  
  def mention_tim_in_body
    @browser.textarea(:class => 'usertext').set "This is a comment mentioning " + '<body><p><a class="jive_macro jive_macro_user" href="javascript:;" jivemacro="user" ___default_attr="2002" data-objecttype="3" data-orig-content="Tim Durden">Tim Durden</a></p></body>'
  end
  
  def mention_matt_in_body
    @browser.textarea(:class => 'usertext').set "This is a comment mentioning " + '<body><p><a class="jive_macro jive_macro_user" href="javascript:;" jivemacro="user" ___default_attr="2001" data-objecttype="3" data-orig-content="willshiremd@surevine">willshiremd@surevine</a></p></body>'
  end
  
  def mention_tim
    @browser.textarea(:class => 'usertext').set "This is a comment mentioning " + '<body><p><a class="jive_macro jive_macro_user" href="javascript:;" jivemacro="user" ___default_attr="2002" data-objecttype="3" data-orig-content="Tim Durden">Tim Durden</a></p></body>'
  end
  
  def mention_matt
    @browser.textarea(:class => 'usertext').set "This is a comment mentioning " + '<body><p><a class="jive_macro jive_macro_user" href="javascript:;" jivemacro="user" ___default_attr="2001" data-objecttype="3" data-orig-content="willshiremd@surevine">willshiremd@surevine</a></p></body>'
  end  
end