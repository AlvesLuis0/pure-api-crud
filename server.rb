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
    @server = TCPServer.new('0.0.0.0', port)
    yield
    loop do
      iteration
    end
  end

  # routes
  def get(path, &block)
    @router.register(:get, path, &block)
  end

  def post(path, &block)
    @router.register(:post, path, &block)
  end

  def put(path, &block)
    @router.register(:put, path, &block)
  end

  def delete(path, &block)
    @router.register(:delete, path, &block)
  end

  private

  def iteration
    socket = @server.accept
    request = Request.new(socket)
    response = Response.new(socket)
    @router.call(request, response)
  end
end
