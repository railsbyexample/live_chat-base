# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# jQuery(document).on 'turbolinks:load', ->
#   messages = $('#messages')
#   if $('#messages').length > 0
#     messages_to_bottom = -> window.scrollTo(0, document.body.scrollHeight)
#     messages_to_bottom()
#     App.global_chat = App.cable.subscriptions.create {
#         channel: "ConversationsChannel"
#         conversation_id: messages.data('conversation-id')
#       },
#       connected: ->
#         # Called when ready
#
#       disconnected: ->
#         # Called when terminated
#
#       received: (data) ->
#         messages.append data['message']
#         messages_to_bottom()
#
#       send_message: (message, conversation_id) ->
#         @perform 'send_message', message: message, conversation_id: conversation_id
#
#     $('#new_message').submit (e) ->
#       $this = $(this)
#       textarea = $this.find('#message_body')
#       if $.trim(textarea.val()).length > 1
#         App.global_chat.send_message textarea.val(), messages.data('conversation-id')
#         textarea.val('')
#       e.preventDefault()
#       return false
