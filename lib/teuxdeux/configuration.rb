require 'faraday'
require 'teuxdeux/version'

module TeuxDeux
  module Configuration
    VALID_OPTIONS_KEYS = [
      :adapter,
      :login,
      :password,
      :proxy,
      :user_agent].freeze

    DEFAULT_ADAPTER    = Faraday.default_adapter
    DEFAULT_LOGIN      = nil
    DEFAULT_PASSWORD   = nil
    DEFAULT_PROXY      = nil
    DEFAULT_USER_AGENT = "TeuxDeux Ruby Gem #{TeuxDeux::VERSION}".freeze

    attr_accessor *VALID_OPTIONS_KEYS

    def self.extended(base)
      base.reset
    end

    def configure
      yield self
    end

    def options
      VALID_OPTIONS_KEYS.inject({}){|o,k| o.merge!(k => send(k)) }
    end

    def reset
      self.adapter     = DEFAULT_ADAPTER
      self.login       = DEFAULT_LOGIN
      self.password    = DEFAULT_PASSWORD
      self.proxy       = DEFAULT_PROXY
      self.user_agent  = DEFAULT_USER_AGENT
    end
  end
end
