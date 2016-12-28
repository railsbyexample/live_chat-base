# Action Cable provides the framework to deal with WebSockets in Rails.
# You can generate new channels where WebSocket features live using the rails generate channel command.
#
# = require action_cable
# = require_self

(->
  this.App || (this.App = {});

  App.cable = ActionCable.createConsumer();
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
).call(this);
