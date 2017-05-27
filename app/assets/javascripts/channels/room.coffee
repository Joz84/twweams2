App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    console.log('Connected to the server')

  disconnected: ->
    # Called when the subscription has been terminated by the server
    console.log('Disconnected from the server')

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    messages = $('.messages-container')
    messages.append(data)
    scroll_bottom(messages)

  speak: (data) ->
    # Triggered when App.room.speak is called
    @perform 'speak', {message: data}


# When return is pressed, the speak function is called and the data is sent to back-end.
$('input[data-behavior="room_speaker"]').on 'keypress', (e) ->
  if e.keyCode is 13
    App.room.speak e.target.value
    e.target.value = ""
    e.preventDefault()


# Function for auto scroll-down
scroll_bottom = (element) ->
  $('body').animate({scrollTop: $(element).height()}, 300);

# Auto-scrolling to bottom when page is loaded
$(document).one 'DOMContentLoaded', ->
  scroll_bottom( $('.messages-container') )
