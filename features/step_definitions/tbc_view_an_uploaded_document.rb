Then /^I can view the uploaded document$/ do
  on(ViewUploadedDocumentPage).wait_until do
    on(ViewUploadedDocumentPage).title?
  end

  fail 'Title not visible' unless on(ViewUploadedDocumentPage).title?
  fail 'IHM not visible' unless on(ViewUploadedDocumentPage).ihm_bar?
  fail 'Choices not visible' unless on(ViewUploadedDocumentPage).first_poll_choice?
  fail 'Comment not visible' unless on(ViewUploadedDocumentPage).comment?
end