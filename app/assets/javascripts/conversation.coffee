jQuery(document).on 'turbolinks:load', ->

  $message_thread = $('#messages')
  App.append_message = (message) ->
    $template = $('#message-template').clone()
    $template.find('#message-user-name').text('user_name')
    $template.find('#message-body').text(message.body)
    $message_thread.append($template)

  $(document).on 'message-received', ->
    App.append_message App.last_message
