describe 'conversation', ->

  it 'should append message to thread if ', ->
    append_spy = spyOn(App, 'append_message').and.callFake(-> true)
    $(document).trigger 'message-received'
    ## Check the subscription has been created
    expect(append_spy).toHaveBeenCalled()
