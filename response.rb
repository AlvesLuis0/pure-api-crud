# frozen_string_literal: true

require 'json'
require_relative 'http_status'

class Response
  def initialize(socket)
    @socket = socket
  end

  def send(status: :ok, body: {})
    @socket.print <<~RESPONSE
      HTTP/1.1 #{HTTP_STATUS_CODE[status]}
      Content-Type: application/json
      Connection: close

      #{JSON.dump(body)}
    RESPONSE

    @socket.close
  end
end
