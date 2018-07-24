document.addEventListener("turbolinks:load", function() {
  var chatMessageBox = document.getElementById("chat_messages");
  var chatMessageForm = document.getElementById("new_chat_message");
  var currentUserId = chatMessageBox.dataset.currentUserId
  var input = document.getElementById("chat_message_body");
  // var button = document.getElementsByClassName("msg_send_btn")[0];

  // message_to_bottom = function(){
  chatMessageBox.scrollTop = chatMessageBox.scrollHeight;
  // }
  // input.addEventListener("keydown", function(event){
  //   if (event.keyCode == 13 && !event.shiftKey){
  //     button.click()
  //     event.target.value = ''
  //     event.preventDefault()
  //   }
  // });


  App.chat = App.cable.subscriptions.create({
      channel: "ChatChannel",
      chat_room_id: chatMessageBox.dataset.chatRoomId
    },
    {
      connected: function(){
        console.log("connected");
      },
      disconnected: function(){
        console.log("disconnected");
      },
      received: function(data){
        var div = document.createElement("div");
        if (data["user_id"] == currentUserId){
          div.className = "outgoing_msg";
          div.innerHTML = data["sent_message"];
          chatMessageBox.appendChild(div);
        }else{
          div.className = "incoming_msg";
          div.innerHTML = data["received_message"];
          chatMessageBox.appendChild(div);
        }
        chatMessageBox.scrollTop = chatMessageBox.scrollHeight;
      },
      send_message: function(chat_message, chat_room_id){
        this.perform("create_message", {
          chat_message: chat_message,
          chat_room_id: chat_room_id
        })
      }
  });

  chatMessageForm.addEventListener("submit", function(event){
    if (input.value.trim().length > 1){
      App.chat.send_message(input.value, chatMessageBox.dataset.chatRoomId)
    }

    input.value = "";
    event.preventDefault();
    return false
  });
});
