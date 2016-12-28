(->

  this.App || (this.App = {})
  this.App.ConversationsIndex =
    init: ->
      $(document).on 'message-received', ->
        App.ConversationsIndex.display_message App.last_message

    display_message: (message) ->
      $conversation = $('#conversation-' + message.conversation_id)
      $conversation.find('#conversation-preview').text(message.user.name + ': ' + message.body)

).call(this)

jQuery(document).on 'turbolinks:load', ->

  ($('#conversations-index').length > 0) && App.ConversationsIndex.init()
