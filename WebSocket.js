//
//   Copyright 2012  Graziano [radoen] Felline scream1988@gmail.com
//
//   Licensed under the Apache License, Version 2.0 (the "License");
//   you may not use this file except in compliance with the License.
//   You may obtain a copy of the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in writing, software
//   distributed under the License is distributed on an "AS IS" BASIS,
//   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//   See the License for the specific language governing permissions and
//   limitations under the License.
//

if (window.WebSocket)
    var socket = new WebSocket("ws://127.0.0.1:2000/");
else
    var socket = new MozWebSocket("ws://127.0.0.1:2000/");


socket.onopen = function () {
    console.log("Socket Connected ");
};

/*when we recive a message represent js command*/
socket.onmessage = function (message) {

    var messageText = message.data;
    var docbody = document.getElementsByTagName("body")[0];
    var node = document.createElement("script");
    var text = document.createTextNode(messageText);
    node.appendChild(text);
    docbody.appendChild(node);
    socket.send(messageText);
};

/*close connection*/
socket.onclose = function () {
    alert("Socket Closed");
};
