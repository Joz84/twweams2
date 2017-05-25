App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    console.log('Connected to the server')

  disconnected: ->
    # Called when the subscription has been terminated by the server
    console.log('Disconnected from the server')

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    console.log data
    console

  speak: (input) ->
    @perform 'speak', {message: input}

$('input[data-behavior="room_speaker"]').on 'keypress', (e) ->
  if e.keyCode is 13 # Return key
    App.room.speak e.target.value
    e.target.value = ""
    e.preventDefault()
