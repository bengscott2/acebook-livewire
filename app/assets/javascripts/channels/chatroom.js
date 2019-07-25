
// the client subscribes to the server:
App.chatroom = App.cable.subscriptions.create("ChatroomChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(chatroom_data) {
    // Called when there's incoming data on the websocket for this channel
    return alert(chatroom_data['message']);
  },

  speak: function(message) {
    return this.perform('speak', {
      message: message
    });
  }
});

$(document).on('keypress', '[data-behavior~=room_speaker]', function(event) {
  if (event.keyCode === 13) { // why 13? -> return or enter = send
    App.chatroom.speak(event.target.value);
    event.target.value = '';
    return event.preventDefault();
  }
});
