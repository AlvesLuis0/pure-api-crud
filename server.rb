# frozen_string_literal: true

require 'socket'
require_relative 'router'
require_relative 'request'
require_relative 'response'

class Server
  def initialize
    @router = Router.new
  end

  def listen(port)
    @server = TCPServer.new('localhost', port)
    yield
    loop do
      iteration
    end
  end

  # routes
  def get(path, &block)
    @router.register(:get, path, &block)
  end

  private

  def iteration
    socket = @server.accept
    request = Request.new(socket)
    response = Response.new(socket)
    @router.call(request, response)
  end
end
