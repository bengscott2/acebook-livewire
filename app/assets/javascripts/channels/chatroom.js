
// the client subscribes to the server:
App.chatroom = App.cable.subscriptions.create("ChatroomChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    // Called when there's incoming data on the websocket for this channel
    alert(data['message'])
  },

  speak: function(message) {
    return this.perform('speak');
  }
});
