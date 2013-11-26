require 'digest/sha1'

module Smscru
  class Callback
    attr_reader :config

    def initialize(options)
      @config = Smscru.config.dup
      @config.update(options)
    end

    def run(params)
      return if params['sha1'] != signature(params)

      if params['mes']
        @on_message.call(params)
      else
        @on_status.call(params)
      end
    end

    def on_message(&block)
      @on_message = block
    end

    def on_status(&block)
      @on_status = block
    end

    def signature(params)
      keys = if params['mes']
        %w(phone mes to)
      else
        %w(id phone status)
      end

      values = params.values_at(*keys) << config.secret

      Digest::SHA1.hexdigest(values.join(':'))
    end
  end
end
