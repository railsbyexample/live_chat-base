(->
  this.App || (this.App = {})
  this.App.Conversation || (this.App.Conversation = {})

  this.App.Conversation.append_message = (message) ->
    $messages_thread = $('#messages')
    $template = $('#message-template').clone()
    $template.find('#message-body').text(message.body)
    $messages_thread.append($template)

  this.App.Conversation.submit_message = (message) ->
    if $.trim(message.body).length > 1
      App.global_messages.send_message message.body, message.conversation_id
).call(this)

jQuery(document).on 'turbolinks:load', ->

  $(document).on 'message-received', ->
    App.Conversation.append_message App.last_message

  $('#new_message').submit (e) ->
    $textarea = $(this).find('#message_body')
    $messages = $('#messages')
    App.Conversation.submit_message(
      body: $textarea.val(),
      conversation_id: $messages.data('conversation-id')
    )
    $textarea.val('')
    e.preventDefault()
    return false
