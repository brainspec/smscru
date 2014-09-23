require 'json'
require 'net/http'
require "faraday"

module Smscru
  class Client
    attr_reader :config

    def initialize(options={})
      @config = Smscru.config.dup
      @config.update(options)
    end

    def send_message(text, phones, options={})
      params = {
        mes:     text,
        phones:  Array(phones).join(','),
        login:   config.login,
        psw:     config.password,
        # charset: 'utf-8',
        fmt:     3
      }

      uri = URI.parse('http://smsc.ru/sys/send.php')
      connection = Faraday.new(url: "#{uri.scheme}://#{uri.host}") do |i|
        i.request  :url_encoded
        i.response :logger
        i.adapter  Faraday.default_adapter
      end
      response = connection.post uri.path, params

      JSON.parse(response.body)
    end
  end
end
