# frozen_string_literal: true

class Router
  def initialize
    @routes = {
      get: {},
      post: {},
      put: {},
      delete: {}
    }
  end

  def register(method, path, &block)
    @routes[method][path] = block
  end

  def call(request, response)
    route = @routes.dig(request.method, request.path)
    if route
      route.call(request, response)
    else
      response.send(status: :not_found, body: { message: 'Resource not found' })
    end
  end
end
