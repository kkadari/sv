class InboxPage
  include PageObject
  extend UrlFactory

  page_url(inboxpage)

  div(:notifications, :css => '.j-act-notifications')
  div(:inbox_message, :css => '.j-aq-entry')
  a(:confirm_notification, :css => '.j-action-button')

end
