describe 'conversation', ->

  it 'should append message to thread when received', ->
    ## Spy on append method
    append_spy = spyOn(App.Conversation, 'append_message').and.callFake(-> true)

    ## Simulate a message is received
    $(document).trigger 'message-received'

    ## Check the message is appended
    expect(append_spy).toHaveBeenCalled()

  describe 'append_message', ->

    beforeEach ->
      $("""
        <div id="fixture">
          <div id="message-template"><div id="message-body"></div></div>
          <div id="messages"></div>
        </div>""").appendTo('body')

    afterEach ->
      $('#fixture').remove()

    it 'should apend a new message to the thread', ->
      message = body: 'message-body'

      ## Apply the method
      App.Conversation.append_message message

      ## Verify the text is appended
      expect($('body').find('#messages #message-body').text()).toEqual(message.body)
