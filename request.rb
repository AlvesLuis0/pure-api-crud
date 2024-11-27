# frozen_string_literal: true

class Request
  attr_reader :params

  def initialize(socket)
    @socket = socket
    @params = parse_params
  end

  private

  def parse_params
    params = @socket.gets.split(' ')
    {
      method: params[0],
      path: params[1]
    }
  end
end
