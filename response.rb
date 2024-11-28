# frozen_string_literal: true

require 'json'

class Response
  def initialize(socket)
    @socket = socket
  end

  def send(status: :ok, body: {})
    @socket.print <<~RESPONSE
      HTTP/1.1 #{get_status(status)}
      Content-Type: application/json

      #{JSON.dump(body)}
    RESPONSE

    @socket.close
  end

  private

  def get_status(status)
    {
      ok: '200 OK',
      not_found: '404 Not Found'
    }[status]
  end
end
