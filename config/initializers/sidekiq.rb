require 'sidekiq/web'

if ENV["REDIS_URL"].present?
  Sidekiq.configure_server do |config|
    config.redis = { url: ENV["REDIS_URL"] }
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: ENV["REDIS_URL"] }
  end
end
