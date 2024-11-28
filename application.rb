# frozen_string_literal: true

require_relative 'server'

server = Server.new
PORT = ENV.fetch('SERVER_PORT', 3000)

server.get('/items') do |_request, response|
  response.send(body: { message: 'Getting items' })
end

server.get('/items/:id') do |_request, response|
  response.send(body: { message: 'Getting items' })
end

server.post('/items') do |_request, response|
  response.send(body: { message: 'Creating item' })
end

server.put('/items/:id') do |_request, response|
  response.send(body: { message: 'Updating item' })
end

server.delete('/items/:id') do |_request, response|
  response.send(body: { message: 'Deleting item' })
end

server.listen(PORT) do
  puts "Server running on port #{PORT}"
end
