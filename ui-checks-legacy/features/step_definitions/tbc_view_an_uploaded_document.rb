Then /^I can view the uploaded document$/ do
  on(ViewUploadedDocumentPage).wait_until do
    on(ViewUploadedDocumentPage).comment? #comment link is one of the last things to load.
  end

  fail 'Title not visible' unless on(ViewUploadedDocumentPage).title?
  fail 'IHM not visible' unless on(ViewUploadedDocumentPage).ihm_bar?
  fail 'Document not visible' unless on(ViewUploadedDocumentPage).document?
  fail 'Comment not visible' unless on(ViewUploadedDocumentPage).comment?
end
