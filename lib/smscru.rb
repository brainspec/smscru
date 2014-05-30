require 'smscru/version'
require 'smscru/configuration'
require 'smscru/client'
require 'smscru/callback'

module Smscru
  extend SingleForwardable

  def_delegators :client, :send_message

  class << self
    attr_reader :config

    def configure(options={}, &block)
      @config = Configuration.new
      @config.update(options)
      yield @config if block_given?
    end

    def client
      @client ||= Client.new
    end
  end

  configure
end
