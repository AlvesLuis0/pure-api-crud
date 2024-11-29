# frozen_string_literal: true

require 'json'
require_relative 'http_status'

class Response
  def initialize(socket)
    @socket = socket
  end

  def send(status: :ok, body: {})
    @socket.print <<~RESPONSE
      HTTP/1.1 #{HTTP_STATUS_CODE[status]}\r
      Content-Type: application/json\r
      Connection: close\r
      \r
      #{JSON.dump(body)}\r
    RESPONSE

    @socket.close
  end
end
