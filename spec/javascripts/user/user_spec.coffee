describe 'user', ->

  ## Fake message
  user = id: '1', name: 'test', gravatar_url: 'url'
  received_message = message: JSON.stringify(conversation_id: '1', body: 'message', user: user)
  sent_message = conversation_id: '1', body: 'message'

  it 'should create a channel subscription', ->
    ## Check the subscription has been created
    expect(App.global_messages).toBeTruthy()

  it 'should fire an event if a message is received', ->
    ## Spy on the expected event
    message_received = jasmine.createSpy 'message_received'
    $(document).on 'message-received', message_received

    ## Trigger the callback
    App.global_messages.received(received_message)

    ## Check the data is set and the event is called
    expect(message_received).toHaveBeenCalled()
    expect(App.last_message).toEqual(JSON.parse(received_message.message))

  it 'should perform send_message on the channel', ->
    ## Spy on perform method
    performed_action = spyOn App.global_messages, 'perform'

    ## Trigger the method
    App.global_messages.send_message sent_message.body, sent_message.conversation_id

    ## Check the action is performed through the channel
    expect(performed_action).toHaveBeenCalledWith('send_message', sent_message)
