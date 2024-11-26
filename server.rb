# frozen_string_literal: true

require 'socket'
require 'json'

class Server
  def listen(port)
    @server = TCPServer.new('localhost', port)
    yield
    looping
  end

  private

  def looping
    loop do
      @socket = @server.accept
      send_response
      @socket.close
    end
  end

  def send_response
    body = JSON.dump({ message: 'Resource not found' })
    headers = "HTTP/1.1 404 Not Found\n" \
              "Content-Type: application/json\n" \
              "Content-Length: #{body.bytesize}\n" \
              "Connection: close\n"
    @socket.print "#{headers}\n#{body}"
  end
end
