Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
        origins 'http://localhost:5173' # this is the port that our React app is running on
        resource '*',
        headers: :any,
        methods: [:get, :post, :put, :patch, :delete, :options, :head]
    end
end