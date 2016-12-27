(->
  this.App || (this.App = {})
  this.App.Conversation || (this.App.Conversation = {})

  this.App.Conversation.append_message = (message) ->
    $messages_thread = $('#messages')
    $template = $('#message-template').clone()
    $template.find('#message-body').text message.body
    $template.find('#message-user-name').text message.user.name
    $template.find('#message-user-gravatar').attr 'src', message.user.gravatar_url
    $messages_thread.append($template)

  this.App.Conversation.submit_message = (e) ->
    $textarea = $('#message_body')
    $messages = $('#messages')
    if $.trim($textarea.val()).length > 1
      App.global_messages.send_message $textarea.val(), $messages.data('conversation-id')
      $textarea.val('')
    e.preventDefault()
    return false
).call(this)

jQuery(document).on 'turbolinks:load', ->

  $(document).on 'message-received', ->
    App.Conversation.append_message App.last_message

  $('#new_message').submit App.Conversation.submit_message
