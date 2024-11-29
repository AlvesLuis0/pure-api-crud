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
    server = TCPServer.new(port)
    yield
    loop do
      Thread.start(server.accept) do |socket|
        @router.call(Request.new(socket), Response.new(socket))
      end
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
end
