Then /^I can view the blog post$/ do
  on(BlogPostSummaryPage).wait_until do
    on(BlogPostSummaryPage).title?
  end

  fail 'Title not visible' unless on(BlogPostSummaryPage).title?
  fail 'IHM not visible' unless on(BlogPostSummaryPage).ihm_bar?
  fail 'Body not visible' unless on(BlogPostSummaryPage).original_message?
  fail 'Comment not visible' unless on(BlogPostSummaryPage).comment?
end