(->
  this.App || (this.App = {})
  this.App.Conversation || (this.App.Conversation = {})
  this.App.Conversation.append_message = (message) ->
    $messages_thread = $('#messages')
    $template = $('#message-template').clone()
    $template.find('#message-body').text(message.body)
    $messages_thread.append($template)

).call(this)

jQuery(document).on 'turbolinks:load', ->

  $message_thread = $('#messages')
  App.append_message = (message) ->
    $template = $('#message-template').clone()
    $template.find('#message-user-name').text('user_name')
    $template.find('#message-body').text(message.body)
    $message_thread.append($template)

  $(document).on 'message-received', ->
    App.Conversation.append_message App.last_message
