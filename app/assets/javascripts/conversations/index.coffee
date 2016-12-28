(->

  this.App || (this.App = {})
  this.App.ConversationsIndex || (this.App.ConversationsIndex = {})

  this.App.ConversationIndex.display_message = (message) ->
    $conversation = $('#conversation-' + message.conversation_id)
    $conversation.find('#conversation-preview').text(message.user.name + ': ' + message.body)

).call(this)

jQuery(document).on 'turbolinks:load', ->

  if $('#conversations-index').length > 0

    $(document).on 'message-received', ->
      App.ConversationsIndex.display_message App.last_message
