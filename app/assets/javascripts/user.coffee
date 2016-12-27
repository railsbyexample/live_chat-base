# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery(document).on 'turbolinks:load', ->
  messages = $('#messages')
  conversations = $('#conversations')

  if messages.length > 0 || conversations.length > 0

    messages_to_bottom = -> window.scrollTo(0, document.body.scrollHeight)
    console.log 'initializing channel'
    messages_to_bottom()

    App.global_messages = App.cable.subscriptions.create {
        channel: "UsersChannel"
      },
      {
        received: (data) ->
          if messages.length > 0
            messages.append data['message']
          if conversations.length > 0
            console.log('notify user: ', data['message'])
          messages_to_bottom()

        send_message: (body, conversation_id) ->
          @perform 'send_message', body: body, conversation_id: conversation_id
      }

    $('#new_message').submit (e) ->
      $this = $(this)
      textarea = $this.find('#message_body')
      if $.trim(textarea.val()).length > 1
        console.log textarea.val()
        App.global_messages.send_message textarea.val(), messages.data('conversation-id')
        textarea.val('')
      e.preventDefault()
      return false
