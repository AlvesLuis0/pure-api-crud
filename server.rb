# frozen_string_literal: true

require 'socket'
require_relative 'request'
require_relative 'response'

class Server
  def listen(port)
    @server = TCPServer.new('localhost', port)
    yield
    loop do
      iteration
    end
  end

  private

  def iteration
    socket = @server.accept
    Request.new(socket)
    Response.new(socket).send(status: :not_found) # TODO: delegate to router
  end
end
