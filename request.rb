# frozen_string_literal: true

class Request
  attr_reader :method, :path

  def initialize(socket)
    @socket = socket
    parse_params
  end

  private

  def parse_params
    params = @socket.gets.split(' ')
    @method = params[0].to_sym.downcase
    @path = params[1]
  end
end
