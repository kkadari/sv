Then /^I? (?:can|have)? (?:comment|commented) on the discussion( anonymously)?$/ do |anonymous|
  visit ContentPage do |content|
    content.content_items_elements.each do |link|
      if link.text.include? @subject[0.23]
        link.click
        break
      end
    end
  end

  fail 'Content not visible or created' unless @browser.html.to_s.include? @subject
  if anonymous
    on ViewDiscussionPage do |comment|
      comment.reply
      comment.enable_html_mode
      comment.comment_body = 'Anonymous comment for discussion'
      comment.check_anonymous
      comment.save
    end
  else
    on(ViewDiscussionPage) do |comment|
      comment.reply
      comment.enable_html_mode
      comment.comment_body = 'A discussion comment'
      comment.save
    end
  end
end

Then /^I can comment on the comment( anonymously)?$/ do |anonymous|
  visit ContentPage do |content|
    content.content_items_elements.each do |link|
      if link.text.include? @subject[0.23]
        link.click
        break
      end
    end
  end

  fail 'Content not visible or created' unless @browser.html.to_s.include? @subject
  if anonymous
    on ViewDiscussionPage do |comment|
      comment.reply
      comment.enable_html_mode
      comment.comment_body = 'Anonymous comment for discussion'
      comment.check_anonymous
      comment.save
    end
  else
    on(ViewDiscussionPage) do |comment|
      comment.reply
      comment.enable_html_mode
      comment.comment_body = 'A discussion comment'
      comment.save
    end
  end
end