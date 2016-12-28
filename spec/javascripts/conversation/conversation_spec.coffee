describe 'ConversationsShow', ->

  beforeEach ->
    $("""
      <div id="fixture">
        <div id="conversations-show"><div id="messages"></div></div>
      </div>
    """).appendTo('body')

  afterEach ->
    $('#fixture').remove()

  it 'should append message to thread when received', ->
    ## Initialize view
    App.ConversationsShow.init()
    ## Spy on append method
    append_spy = spyOn(App.ConversationsShow, 'append_message').and.callFake(-> true)

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
        </div>
      """).appendTo('body')

    afterEach ->
      $('#fixture').remove()

    it 'should apend a new message to the thread', ->
      ## Mock message
      message = body: 'message-body', user: { name: 'test', gravatar_url: 'url' }

      ## Apply the method
      App.ConversationsShow.append_message message

      ## Verify the text is appended
      expect($('body').find('#messages #message-body').text()).toEqual(message.body)
