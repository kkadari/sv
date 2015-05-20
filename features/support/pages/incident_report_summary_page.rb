class IncidentReportSummaryPage
  include PageObject
  extend UrlFactory

  page_url(incidentreportsummarypage)

  h1(:title, :css => '.jive-incidentreport h1')

  div(:first_comment, :class => 'jive-comment-container')

  div(:delete_confirm, :id => 'jive-modal-incidentreport-delete')
  button(:confirm_delete, :id => 'deletebutton')

end