# frozen_string_literal: true

require_relative 'server'

server = Server.new
PORT = ENV.fetch('SERVER_PORT', 3000)

server.listen(PORT) do
  puts "Server running on port #{PORT}"
end
