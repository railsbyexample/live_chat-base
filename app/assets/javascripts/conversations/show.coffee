(->

  this.App || (this.App = {})
  this.App.ConversationsShow =
    init: ->
      $(document).on 'message-received', ->
        App.ConversationsShow.append_message App.last_message
        App.ConversationsShow.scroll_to_bottom()
      $('#new_message').submit App.ConversationsShow.submit_message
      App.ConversationsShow.scroll_to_bottom()

    scroll_to_bottom: -> window.scrollTo(0, document.body.scrollHeight)

    append_message: (message) ->
      $messages_thread = $('#messages')
      $template = $('#message-template').clone()
      $template.find('#message-body').text message.body
      $template.find('#message-user-name').text message.user.name
      $template.find('#message-user-gravatar').attr 'src', message.user.gravatar_url
      $messages_thread.append($template)

    submit_message: (e) ->
      $textarea = $('#message_body')
      $messages = $('#messages')
      if $.trim($textarea.val()).length > 1
        App.global_messages.send_message $textarea.val(), $messages.data('conversation-id')
        $textarea.val('')
      e.preventDefault()
      return false

).call(this)

jQuery(document).on 'turbolinks:load', ->

  ($('#conversations-show').length > 0) && App.ConversationsShow.init()
