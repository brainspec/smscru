require 'json'
require 'net/http'

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
        phones:  Array(phones),
        login:   config.login,
        psw:     config.password,
        charset: 'utf-8',
        fmt:     3
      }

      uri = URI.parse('http://smsc.ru/sys/send.php')
      response = Net::HTTP.post_form(uri, params.merge(options))

      JSON.parse(response.body)
    end
  end
end
