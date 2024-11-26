# frozen_string_literal: true

require 'yaml'
require 'json'
require 'socket'

config = YAML.load_file('config/server.yml')

server = TCPServer.new(
  config['host'],
  config['port']
)

def send_response(client, status, body)
  body = JSON.dump(body)
  headers = "HTTP/1.1 #{status}\n" \
            "Content-Type: application/json\n" \
            "Content-Length: #{body.bytesize}\n" \
            "Connection: close\n"
  client.print headers
  client.print "\n"
  client.print body
end

loop do
  client = server.accept

  body = { message: 'Hello, world!' }
  send_response(client, '200 OK', body)

  client.close
end
