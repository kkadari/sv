Then /^I? (?:can|have)? (?:comment|commented) on the discussion( anonymously)?$/ do |anonymous|
  on(HomePage).click_content
  on(ContentPage).navigate_to_discussion_named(@subject)
  on(ViewDiscussionPage).verify_content_exists(@subject)
  if (anonymous)
    on(ViewDiscussionPage).comment_anonymously_on_discussion
  else
    on(ViewDiscussionPage).add_discussion_comment
  end
end

Then /^I can comment on the comment( anonymously)?$/ do |anonymous|
  on(HomePage).click_content
  on(ContentPage).navigate_to_discussion_named(@subject)
  on(ViewDiscussionPage).verify_content_exists(@subject)
  if (anonymous)
    on(ViewDiscussionPage).comment_anonymously_on_comment  
  else
    on(ViewDiscussionPage).comment_on_comment
  end
end