# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery(document).on 'turbolinks:load', ->
  App.global_messages = App.cable.subscriptions.create {
    channel: "UsersChannel"
  },
  {
    received: (data) ->
      App.last_message = JSON.parse(data.message)
      $(document).trigger 'message-received'
    send_message: (body, conversation_id) ->
      @perform 'send_message', body: body, conversation_id: conversation_id
  }
