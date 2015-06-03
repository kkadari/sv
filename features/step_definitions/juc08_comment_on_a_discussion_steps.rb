Then /^I? (?:can|have)? (?:comment|commented) on the discussion( anonymously)?$/ do |anonymous|
  visit_and_benchmark ContentPage do |content|
    content.content_items_elements.each do |link|
      if link.text.include? @subject[0.23]
        link.click
        break
      end
    end
  end

  on ViewDiscussionPage do |comment|
    comment.wait_until do
      comment.title?
    end

    comment.reply
    comment.enable_html_mode
    comment.comment_body = 'A discussion comment'
    comment.anonymous if anonymous
    comment.save
  end
end

Then /^I can comment on the comment( anonymously)?$/ do |anonymous|
  visit_and_benchmark ContentPage do |content|
    content.content_items_elements.each do |link|
      if link.text.include? @subject[0.23]
        link.click
        break
      end
    end
  end

  on ViewDiscussionPage do |comment|
    comment.wait_until do
      comment.title?
    end

    comment.reply
    comment.enable_html_mode
    comment.comment_body = 'Anonymous comment for discussion'
    comment.anonymous if anonymous
    comment.save
  end
end