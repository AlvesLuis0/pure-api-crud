# frozen_string_literal: true

require 'socket'
require_relative 'response'

class Server
  def listen(port)
    @server = TCPServer.new('localhost', port)
    yield
    looping
  end

  private

  def looping
    loop do
      socket = @server.accept
      Response.new(socket).send(status: :not_found) # TODO: delegate to router
    end
  end
end
