require 'smscru/version'
require 'smscru/configuration'
require 'smscru/client'
require 'smscru/callback'

module Smscru
  class << self
    attr_reader :config

    def configure(options={}, &block)
      @config = Configuration.new
      @config.update(options)
      yield @config if block_given?
    end
  end

  configure
end
