Then /^I? (?:can|have)? (?:comment|commented) on the discussion( anonymously)?$/ do |anonymous|
  on(GlobalNav).content
  on(ContentPage).navigate_to_discussion_named(@subject)
  fail 'Content not visible or created' unless @browser.html.to_s.include? @subject
  if anonymous
    on(ViewDiscussionPage).comment_anonymously_on_discussion
  else
    on(ViewDiscussionPage).add_discussion_comment
  end
end

Then /^I can comment on the comment( anonymously)?$/ do |anonymous|
  on(GlobalNav).content
  on(ContentPage).navigate_to_discussion_named(@subject)
  fail 'Content not visible or created' unless @browser.html.to_s.include? @subject
  if anonymous
    on(ViewDiscussionPage).comment_anonymously_on_comment  
  else
    on(ViewDiscussionPage).comment_on_comment
  end
end