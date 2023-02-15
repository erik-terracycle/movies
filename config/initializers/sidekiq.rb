# frozen_string_literal: true

redis_config = {
  url: ENV['REDISCLOUD_URL'] || ENV['REDIS_URL']
}

Sidekiq.configure_server do |config|
  config.redis = redis_config
  config.logger.level = Rails.env.development? ? Logger::INFO : Logger::WARN

  config.client_middleware do |chain|
    chain.add SidekiqUniqueJobs::Middleware::Client
  end

  config.server_middleware do |chain|
    chain.add SidekiqUniqueJobs::Middleware::Server
  end

  SidekiqUniqueJobs::Server.configure(config)
end

Sidekiq.configure_client do |config|
  config.redis = redis_config

  config.client_middleware do |chain|
    chain.add SidekiqUniqueJobs::Middleware::Client
  end
end

Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  # Protect against timing attacks:
  # - See https://codahale.com/a-lesson-in-timing-attacks/
  # - See https://thisdata.com/blog/timing-attacks-against-string-comparison/
  # - Use & (do not use &&) so that it doesn't short circuit.
  # - Use digests to stop length information leaking (see also ActiveSupport::SecurityUtils.variable_size_secure_compare)

  digest = ->(string) { ::Digest::SHA256.hexdigest(string.to_s) }
  creds = Rails.application.credentials.sidekiq

  ActiveSupport::SecurityUtils.secure_compare(digest.(username), digest.(ENV['SIDEKIQ_USERNAME'])) &
    ActiveSupport::SecurityUtils.secure_compare(digest.(password), digest.(ENV['SIDEKIQ_PASSWORD']))
end

