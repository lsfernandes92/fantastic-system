App.notifications = App.cable.subscriptions.create("NotificationsChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    // Called when there's incoming data on the websocket for this channel
    var theDiv = document.getElementById("notifications");
    var content = document.createTextNode(data['html']);
    theDiv.appendChild(content);

    $(document).ready(function(){
      setTimeout(function(){
        $('#notification_wrapper').fadeOut("slow");
        theDiv.innerHTML = "";
        $('#notification_wrapper').fadeIn("slow")
      }, 4500);
    });
  }
});
