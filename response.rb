# frozen_string_literal: true

require 'json'

class Response
  def initialize(socket)
    @socket = socket
  end

  def send(status: :ok, body: {})
    status = get_status(status)
    body = JSON.dump(body)
    headers = "HTTP/1.1 #{status}\n" \
                  "Content-Type: application/json\n" \
                  "Content-Length: #{body.bytesize}\n" \
                  "Connection: close\n"
    @socket.print("#{headers}\n#{body}")
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
