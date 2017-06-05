module Gush
  class Configuration
    attr_accessor :concurrency, :namespace, :redis_url, :redis_prefix, :environment, :sidekiq_queue

    def self.from_json(json)
      new(Gush::JSON.decode(json, symbolize_keys: true))
    end

    def initialize(hash = {})
      self.concurrency = hash.fetch(:concurrency, 5)
      #self.namespace   = hash.fetch(:namespace, 'gush')
      self.redis_url   = hash.fetch(:redis_url, 'redis://localhost:6379')
      self.redis_prefix   = hash.fetch(:redis_prefix, 'gush')
      self.sidekiq_queue   = hash.fetch(:sidekiq_queue, 'gush')
      self.gushfile    = hash.fetch(:gushfile, 'Gushfile.rb')
      self.environment = hash.fetch(:environment, 'development')
    end

    def gushfile=(path)
      @gushfile = Pathname(path)
    end

    def gushfile
      @gushfile.realpath
    end

    def to_hash
      {
        concurrency: concurrency,
        namespace:   namespace,
        redis_url:   redis_url,
        redis_prefix:   redis_prefix,
        sidekiq_queue:   sidekiq_queue,
        environment: environment
      }
    end

    def to_json
      Gush::JSON.encode(to_hash)
    end
  end
end
