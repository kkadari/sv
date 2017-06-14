Then /^I can view the blog post$/ do
  on(BlogPostSummaryPage).wait_until do
    on(BlogPostSummaryPage).comment? #comment link is one of the last things to load.
  end

  fail 'Title not visible' unless on(BlogPostSummaryPage).title?
  fail 'IHM not visible' unless on(BlogPostSummaryPage).ihm_bar?
  fail 'Body not visible' unless on(BlogPostSummaryPage).blog_body?
  fail 'Comment not visible' unless on(BlogPostSummaryPage).comment?
end
