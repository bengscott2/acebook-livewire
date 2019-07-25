
// the client subscribes to the server:
App.chatroom = App.cable.subscriptions.create("ChatroomChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  // `received` looks after how data from the server-side are handled
  received: function(data) {
    // Called when there's incoming data on the websocket for this channel
  },

  // used to send data to its server-side representation
  speak: function() {
    return this.perform('speak');
  }
});
