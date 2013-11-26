module Smscru
  class Configuration
    attr_accessor :login, :password, :secret

    def update(options={})
      options.each_pair do |name, value|
        setter = "#{name}="
        if respond_to?(setter)
          public_send(setter, value)
        end
      end
    end
  end
end
