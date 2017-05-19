App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    console.log data['message']

  speak: (message) ->
    @perform 'speak', {message: message}

$('input[data-behavior="room_speaker"]').on 'keypress', (e) ->
  if e.keyCode is 13 # Return
    App.room.speak e.target.value
    e.target.value = ""
    e.preventDefault()
